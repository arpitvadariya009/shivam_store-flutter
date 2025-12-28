import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/shop/model/product_detail_model.dart';
import '../../../core/utils/app_colors.dart';

class ShopDetailController extends GetxController {
  ShopDetailController({this.id, this.title, this.bgColor});
  final ApiService _apiService = ApiService.instance;
  ApiResponse<ProductsDetailModel?> productsModel =
      ApiResponse<ProductsDetailModel?>();
  Color? bgColor = Colors.black;
  Color? textColor = AppColors.whiteColor;
  String? id = "";
  String? title = "";
  @override
  void onInit() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    try {
      id = Get.arguments['id'];
      title = Get.arguments['title'];
      bgColor = Get.arguments['bgColor'];
      textColor = Get.arguments['textColor'];
    } catch (e) {}

    if (title == "FAVORITE") {
      fetchFavProduct();
    } else {
      fetchProduct();
    }
    super.onInit();
  }

  Future<void> fetchFavProduct() async {
    productsModel = ApiResponse<ProductsDetailModel>().loading();
    update(); // Update UI to show loading

    final response = await _apiService.get<ProductsDetailModel?>(
      '${ApiEndpoints.getFavorite}${HiveService().getValue(HiveService.userId)}',
      parser: (data) {
        if (data == null || data is! Map<String, dynamic>) {
          return ProductsDetailModel(message: "", data: []);
        }
        return ProductsDetailModel.fromJson(data);
      },
    );

    for (int i = 0; i < response.data!.data!.length; i++) {
      response.data!.data![i].isFavorite = true;
    }
    update(); // Update UI with data or error

    productsModel = response;
    productsModel.data?.data?.sort((a, b) {
      final regExp = RegExp(r'([a-zA-Z]+)\s*(\d+)');

      final aCode = a.code ?? '';
      final bCode = b.code ?? '';

      final aMatch = regExp.firstMatch(aCode);
      final bMatch = regExp.firstMatch(bCode);

      // If format doesn't match, fallback
      if (aMatch == null || bMatch == null) {
        return aCode.toLowerCase().compareTo(bCode.toLowerCase());
      }

      // Alphabet part (CB)
      final aPrefix = aMatch.group(1)!.toLowerCase();
      final bPrefix = bMatch.group(1)!.toLowerCase();

      final prefixCompare = aPrefix.compareTo(bPrefix);
      if (prefixCompare != 0) return prefixCompare;

      // Numeric part (1, 2, 10, 301...)
      final aNumber = int.parse(aMatch.group(2)!);
      final bNumber = int.parse(bMatch.group(2)!);

      return aNumber.compareTo(bNumber);
    });
    update(); // Update UI with data or error
  }

  Future<void> fetchProduct() async {
    productsModel = ApiResponse<ProductsDetailModel>().loading();
    update(); // Update UI to show loading

    final response = await _apiService.get<ProductsDetailModel?>(
      '${ApiEndpoints.getProducts}?subCategoryId=$id&userId=${HiveService().getValue(HiveService.userId)}',
      parser: (data) => ProductsDetailModel.fromJson(data),
    );

    log(
      "----------------ids here -->${ApiEndpoints.getProducts}?subCategoryId=$id",
    );

    productsModel = response;
    productsModel.data?.data?.sort((a, b) {
      final regExp = RegExp(r'([a-zA-Z]+)\s*(\d+)');

      final aCode = a.code ?? '';
      final bCode = b.code ?? '';

      final aMatch = regExp.firstMatch(aCode);
      final bMatch = regExp.firstMatch(bCode);

      // If format doesn't match, fallback
      if (aMatch == null || bMatch == null) {
        return aCode.toLowerCase().compareTo(bCode.toLowerCase());
      }

      // Alphabet part (CB)
      final aPrefix = aMatch.group(1)!.toLowerCase();
      final bPrefix = bMatch.group(1)!.toLowerCase();

      final prefixCompare = aPrefix.compareTo(bPrefix);
      if (prefixCompare != 0) return prefixCompare;

      // Numeric part (1, 2, 10, 301...)
      final aNumber = int.parse(aMatch.group(2)!);
      final bNumber = int.parse(bMatch.group(2)!);

      return aNumber.compareTo(bNumber);
    });
    update(); // Update UI with data or error
  }
}

class ShopDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShopDetailController());
  }
}
