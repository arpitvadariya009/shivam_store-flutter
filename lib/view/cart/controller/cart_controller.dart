import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/loader_service.dart';
import 'package:shivam_stores/core/utils/toast_utils.dart';
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
      parser: (data) {
        print("-------response--->${data}");
        return CartModel.fromJson(data);
      },
    );
    cartModel = response;
    update();
  }

  Future<void> placeOder({required BuildContext context}) async {
    LoaderService.instance.show(context);

    print(
      "-------HiveService().getValue(HiveService.userId)--->${HiveService().getValue(HiveService.userId).toString()}",
    );
    dynamic temp;
    ApiResponse response = await _apiService.post<dynamic>(
      ApiEndpoints.placeOrder,
      data: {"userId": HiveService().getValue(HiveService.userId).toString()},
      parser: (data) => temp = data,
    );
    LoaderService.instance.hide();
    if (response.error != null) {
      await showToast(message: response.error ?? "");
    } else {
      await showToast(message: response.data['message'] ?? "");
      Get.toNamed(AppRoutes.kOrdersScreen);
    }
    update();
  }
}

class CartBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}
