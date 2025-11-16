import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/cart/controller/cart_controller.dart';
import 'package:shivam_stores/view/home/model/categories_model.dart';
import 'package:shivam_stores/view/shop/controller/shop_controller.dart';
import 'package:shivam_stores/view/shop/controller/shop_detail_controller.dart';
import 'package:shivam_stores/view/shop/model/product_detail_model.dart';

class ProductDetailController extends GetxController {
  String id = "";
  TapDownDetails? doubleTapDetails;
  String title = "";
  TransformationController transformationController =
      TransformationController();

  Color bgColor = Colors.transparent;
  Color? textColor = AppColors.whiteColor;
  int? index;
  ProductsDetailModel? categoriesModel;
  List<Variant>? variants;
  final ApiService _apiService = ApiService.instance;
  ApiResponse<ProductsDetailModel?> productsDetailModel =
      ApiResponse<ProductsDetailModel?>();

  List<CartData>? cartData;

  String? categoryId;
  @override
  void onInit() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    try {
      id = Get.arguments['id'];
      index = Get.arguments['index'];
      title = Get.arguments['title'];
      bgColor = Get.arguments['bgColor'];
      textColor = Get.arguments['textColor'];
      variants = Get.arguments['variants'];
      cartData = Get.arguments['cartdata'];
      categoryId = Get.arguments['categoryId'];
    } catch (e) {}
    fetchProduct();
    super.onInit();
  }

  Future<void> fetchProduct() async {
    print("-------------------->title-->${title}");
    // if (title.contains('CART')) {
    //   print("-------------------->CART title-->${title}");

    //   productsDetailModel = ApiResponse<ProductsDetailModel?>().loading();
    //   update();
    //   final response = await _apiService.get<ProductsDetailModel?>(
    //     '${ApiEndpoints.product}?productId=$id',
    //     parser: (data) => ProductsDetailModel.fromJson(data),
    //   );

    //   categoriesModel = response.data;
    //   if (variants != null || variants!.isNotEmpty) {
    //     categoriesModel?.data?[0].variants =
    //         variants?.where((element) => element.qty != 0).toList();
    //   }
    // } else
    if (title.contains('MANAGE ORDERS') || title.contains('CART')) {
      if (cartData != null) {
        categoriesModel = ProductsDetailModel(data: cartData ?? []);
      }
    } else {
      if (Get.isRegistered<ShopDetailController>()) {
        categoriesModel = Get.find<ShopDetailController>().productsModel.data;

        print(
          "-------------------->product categoriesModel-->${categoriesModel?.toJson()}",
        );
      }
    }
    update();
  }

  Future<void> addToCart({
    required Variant? varinat,
    required String productCode,
    required int increment,
    required String productId,
  }) async {
    log("--------increment--->${increment}");
    if (title.contains('CART')) {
      await _apiService.put(
        ApiEndpoints.updateToCart,
        data: {
          "categoryId": categoryId ?? Get.find<ShopController>().id,
          "userId": HiveService().getValue(HiveService.userId),
          "productCode": productCode,
          "productId": productId,
          "variantName": varinat?.name,
          "increment": increment,
        },
      );
      Get.find<CartController>().fetchCart();
    } else {
      await _apiService.post(
        ApiEndpoints.addToOrder,
        data: {
          "userId": HiveService().getValue(HiveService.userId),
          "productCode": productCode,
          "productId": productId,
          "variantName": varinat?.name,
          "increment": increment,
          "categoryId":
              Get.find<ShopController>().id, // ✅ fixed (removed space)
        },
      );
    }

    update();
  }

  outOfStock({
    required String productId,
    required String variantId,
    required bool available,
  }) async {
    await _apiService.get(
      '${ApiEndpoints.getToAvailable}?productId=$productId&variantId=$variantId&available=$available',
    );
  }

  Future<void> addToFavorite({
    required String productId,
    required bool isFavorite,
  }) async {
    print(
      "--------------->isFavorite--->${isFavorite == true ? ApiEndpoints.createFavorite : ApiEndpoints.deleteFavorite}",
    );
    print(
      "--------------->data--->${{"userId": HiveService().getValue(HiveService.userId), "productId": productId}}",
    );

    if (isFavorite == true) {
      await _apiService.post(
        ApiEndpoints.createFavorite,
        data: {
          "userId": HiveService().getValue(HiveService.userId),
          "productId": productId,
        },
      );
    } else {
      await _apiService.delete(
        ApiEndpoints.deleteFavorite,
        data: {
          "userId": HiveService().getValue(HiveService.userId),
          "productId": productId,
        },
      );
    }

    if (title.contains('FAVORITE')) {
      if (Get.isRegistered<ShopDetailController>()) {
        Get.find<ShopDetailController>().fetchFavProduct();
        Get.find<ShopDetailController>().update();
      }
    }
    update();
  }
}

class ProductDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController());
  }
}
