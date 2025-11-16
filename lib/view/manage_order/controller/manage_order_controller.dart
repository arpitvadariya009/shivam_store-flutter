import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shivam_stores/core/utils/loader_service.dart';
import 'package:shivam_stores/core/utils/toast_utils.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/manage_order/model/manage_order_model.dart';

class ManageOrderController extends GetxController {
  final ApiService _apiService = ApiService.instance;
  ApiResponse<ManageOrderModel?> orderModel = ApiResponse<ManageOrderModel?>();
  int? buttonIndex;

  String? value;
  String? selectedCategoryName;
  String? statusID;
  List categoryName = jsonDecode(HiveService().getValue(HiveService.category));
  @override
  void onInit() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    fetchOrder();
    super.onInit();
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
    required BuildContext context,
    DateTime? date,
    String? statusFilter = "",
    String? category = "",
    bool? hideApi,
  }) async {
    LoaderService.instance.show(context);
    dynamic temp;
    ApiResponse response = await _apiService.put<dynamic>(
      ApiEndpoints.updateOrder,
      data: {"orderId": orderId, "status": status},
      parser: (data) => temp = data,
    );

    print("----------------temp---->${temp}");
    LoaderService.instance.hide();
    if (response.error != null) {
      await showToast(message: response.error ?? "");
    } else {
      await showToast(message: response.data['message'] ?? "");
    }

    if (!(hideApi ?? false)) {
      fetchOrder(date: date, status: statusFilter, category: category);
    }
    update();
    Get.back();
  }

  Future<void> fetchOrder({
    DateTime? date,
    String? status = "",
    String? category = "",
  }) async {
    orderModel = ApiResponse<ManageOrderModel?>().loading();
    update();
    print(
      "-------HiveService().getValue(HiveService.userId)--->${HiveService().getValue(HiveService.userId).toString()}",
    );
    print(
      "-------uri--->${ApiEndpoints.allGroupedOrders}?status=$status&category=${category ?? ''}&date=${date == null ? "" : DateFormat('yyyy-MM-dd').format(date)}",
    );

    final response = await _apiService.get<ManageOrderModel?>(
      "${ApiEndpoints.allGroupedOrders}?status=$status&category=${category ?? ''}&date=${date == null ? "" : DateFormat('yyyy-MM-dd').format(date)}",
      parser: (data) {
        print("------------------>data---->${data}");

        return ManageOrderModel.fromJson(data);
      },
    );
    print("------------------>response---->${response.data?.toJson()}");
    orderModel = response;
    update();
  }
}

class ManageOrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageOrderController());
  }
}
