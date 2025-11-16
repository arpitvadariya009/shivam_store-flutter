import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
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
      parser: (data) {
        log("----------data--->${data}");

        return OrderModel.fromJson(data);
      },
    );

    log("----------response--->${response}");

    orderModel = response;
    update();
  }
}

class OrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersController());
  }
}
