import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/home/model/categories_model.dart';
import 'package:shivam_stores/view/shop/controller/shop_controller.dart';
import 'package:shivam_stores/view/shop/controller/shop_detail_controller.dart';
import 'package:shivam_stores/view/shop/model/product_detail_model.dart';

class ProductDetailController extends GetxController {
  String id = "";
  String title = "";
  Color bgColor = Colors.transparent;
  Color? textColor = AppColors.whiteColor;
  int? index;
  ProductsDetailModel? categoriesModel;
  List<Variant>? variants;
  final ApiService _apiService = ApiService.instance;
  ApiResponse<ProductsDetailModel?> productsDetailModel =
      ApiResponse<ProductsDetailModel?>();
  @override
  void onInit() {
    try {
      id = Get.arguments['id'];
      index = Get.arguments['index'];
      title = Get.arguments['title'];
      bgColor = Get.arguments['bgColor'];
      textColor = Get.arguments['textColor'];
      variants = Get.arguments['variants'];
    } catch (e) {}
    fetchProduct();
    super.onInit();
  }

  Future<void> fetchProduct() async {
    print("-------------------->title-->${title}");
    if (title.contains('CART')) {
      productsDetailModel = ApiResponse<ProductsDetailModel?>().loading();
      update();
      final response = await _apiService.get<ProductsDetailModel?>(
        '${ApiEndpoints.product}?productId=$id',
        parser: (data) => ProductsDetailModel.fromJson(data),
      );

      categoriesModel = response.data;
      if (variants != null || variants!.isNotEmpty) {
        categoriesModel?.data?[0].variants = variants;
      }
    } else {
      categoriesModel = Get.find<ShopDetailController>().productsModel.data;
    }
    update();
  }

  Future<void> addToCart({
    required Variant? varinat,
    required String productCode,
    required String increment,
    required String productId,
  }) async {
    if (title.contains('CART')) {
      await _apiService.put(
        ApiEndpoints.updateToCart,
        data: {
          "userId": HiveService().getValue(HiveService.userId),
          "productCode": productCode,
          "productId": productId,
          "variantName": varinat?.name,
          "increment": increment,
        },
      );
    } else {
      await _apiService.post(
        ApiEndpoints.addToOrder,
        data: {
          "categoryId ": Get.find<ShopController>().id,
          "userId": HiveService().getValue(HiveService.userId),
          "productCode": productCode,
          "productId": productId,
          "variantName": varinat?.name,
          "increment": increment,
        },
      );
    }

    update();
  }

  Future<void> addToFavorite({
    required String productId,
    required bool isFavorite,
  }) async {
    await _apiService.post(
      isFavorite == true
          ? ApiEndpoints.createFavorite
          : ApiEndpoints.deleteFavorite,
      data: {
        "userId": HiveService().getValue(HiveService.userId),
        "productId": productId,
      },
    );
    update();
  }
}

class ProductDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController());
  }
}
