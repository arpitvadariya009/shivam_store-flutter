import 'package:get/get.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/shop/model/product_detail_model.dart';

class ProductDetailController extends GetxController {
  String id = "";
  final ApiService _apiService = ApiService.instance;
  ApiResponse<ProductsDetailModel?> productsDetailModel =
      ApiResponse<ProductsDetailModel?>();
  @override
  void onInit() {
    id = Get.arguments['id'];
    fetchProduct();
    super.onInit();
  }

  Future<void> fetchProduct() async {
    productsDetailModel = ApiResponse<ProductsDetailModel>().loading();
    update();
    final response = await _apiService.get<ProductsDetailModel?>(
      '${ApiEndpoints.product}?productId=$id',
      parser: (data) => ProductsDetailModel.fromJson(data),
    );

    productsDetailModel = response;
    update();
  }

  Future<void> addToCart({
    required Variant? varinat,
    required String productCode,
    required String increment,
  }) async {
    await _apiService.post(
      ApiEndpoints.addToOrder,
      data: {
        "userId": HiveService().getValue(HiveService.userId),
        "productCode": productCode,
        "variantName": varinat?.name,
        "increment": increment,
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
