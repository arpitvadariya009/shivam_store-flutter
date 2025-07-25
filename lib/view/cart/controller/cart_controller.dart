import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/cart/model/cart_model.dart';

class CartController extends GetxController {
  final ApiService _apiService = ApiService.instance;
  ApiResponse<CartModel?> cartModel = ApiResponse<CartModel?>();
  TextEditingController noteTXTController = TextEditingController();
  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }

  Future<void> fetchCart() async {
    cartModel = ApiResponse<CartModel?>().loading();
    update();
    print(
      "-------HiveService().getValue(HiveService.userId)--->${HiveService().getValue(HiveService.userId).toString()}",
    );
    final response = await _apiService.get<CartModel?>(
      '${ApiEndpoints.getToCart}${HiveService().getValue(HiveService.userId)}',
      parser: (data) => CartModel.fromJson(data),
    );

    cartModel = response;
    update();
  }
}

class CartBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}
