import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/utils/loader_service.dart';
import 'package:shivam_stores/core/utils/toast_utils.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/orders/model/order_model.dart';

class OrdersController extends GetxController {
  final ApiService _apiService = ApiService.instance;
  ApiResponse<OrderModel?> orderModel = ApiResponse<OrderModel?>();

  String? statusID;
  @override
  void onInit() {
    fetchOrder();
    super.onInit();
  }

  Future<void> fetchOrder() async {
    orderModel = ApiResponse<OrderModel?>().loading();
    update();
    print(
      "-------HiveService().getValue(HiveService.userId)--->${HiveService().getValue(HiveService.userId).toString()}",
    );
    final response = await _apiService.get<OrderModel?>(
      '${ApiEndpoints.groupedOrders}?userId=${HiveService().getValue(HiveService.userId)}',
      parser: (data) => OrderModel.fromJson(data),
    );

    orderModel = response;
    update();
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
    required BuildContext context,
  }) async {
    LoaderService.instance.show(context);
    dynamic temp;
    ApiResponse response = await _apiService.put<dynamic?>(
      ApiEndpoints.updateOrder,
      data: {"orderId": orderId, "status": status},
      parser: (data) => temp = data,
    );
    LoaderService.instance.hide();
    if (response.error != null) {
      await showToast(message: response.error ?? "");
    } else {
      await showToast(message: response.data['message'] ?? "");
    }
    fetchOrder();
    update();
    Get.back();
  }
}
