import 'package:get/get.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/view/shop/model/sub_cat_model.dart';

class ShopController extends GetxController {
  String title = "";
  String id = "";
  final ApiService _apiService = ApiService.instance;
  ApiResponse<SubCategoriesModel?> subCategoriesModel =
      ApiResponse<SubCategoriesModel?>();
  @override
  void onInit() {
    title = Get.arguments['title'];
    id = Get.arguments['id'];
    fetchSubCategories();
    super.onInit();
  }

  Future<void> fetchSubCategories() async {
    subCategoriesModel = ApiResponse<SubCategoriesModel>().loading();
    update();
    final response = await _apiService.get<SubCategoriesModel?>(
      '${ApiEndpoints.getAllSubCategories}?categoryId=$id',
      parser: (data) => SubCategoriesModel.fromJson(data),
    );

    subCategoriesModel = response;
    update();
  }
}

class ShopBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShopController());
  }
}
