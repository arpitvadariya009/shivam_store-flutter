import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/shop/model/sub_cat_model.dart';

class ShopController extends GetxController {
  String title = "";
  String id = "";
  final ApiService _apiService = ApiService.instance;
  ApiResponse<SubCategoriesModel?> subCategoriesModel =
      ApiResponse<SubCategoriesModel?>();
  @override
  void onInit() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    title = Get.arguments['title'];
    id = Get.arguments['id'];
    fetchSubCategories();
    super.onInit();
  }

  Future<void> fetchSubCategories() async {
    subCategoriesModel = ApiResponse<SubCategoriesModel>().loading();
    update();
  
  
    final response = await _apiService.get<SubCategoriesModel?>(
      '${ApiEndpoints.getAllSubCategories}?userId=${HiveService().getValue(HiveService.userId)}&categoryId=$id',
      parser: (data) => SubCategoriesModel.fromJson(data),
    );

    subCategoriesModel = response;

    subCategoriesModel.data?.subCategories?.sort(
      (a, b) => (a.name ?? '').compareTo(b.name ?? ''),
    );
    update();
  }
}

class ShopBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShopController());
  }
}
