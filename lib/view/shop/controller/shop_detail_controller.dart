import 'package:get/get.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/view/home/model/categories_model.dart';

class ShopDetailController extends GetxController {
  final ApiService _apiService = ApiService.instance;
  ApiResponse<CategoriesModel?> productsModel = ApiResponse<CategoriesModel?>();

  String id = "";
  String title = "";
  @override
  void onInit() {
    id = Get.arguments['id'];
    title = Get.arguments['title'];
    fetchProduct();
    super.onInit();
  }

  Future<void> fetchProduct() async {
    productsModel = ApiResponse<CategoriesModel>().loading();
    update(); // Update UI to show loading

    final response = await _apiService.get<CategoriesModel?>(
      '${ApiEndpoints.getProducts}?subCategoryId=$id',
      parser: (data) => CategoriesModel.fromJson(data),
    );

    productsModel = response;
    update(); // Update UI with data or error
  }
}

class ShopDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShopDetailController());
  }
}
