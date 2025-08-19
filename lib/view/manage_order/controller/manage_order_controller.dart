import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/manage_order/model/manage_order_model.dart';

class ManageOrderController extends GetxController {
  final ApiService _apiService = ApiService.instance;
  ApiResponse<ManageOrderModel?> orderModel = ApiResponse<ManageOrderModel?>();
  int buttonIndex = 0;
  @override
  void onInit() {
    fetchOrder();
    super.onInit();
  }

  Future<void> fetchOrder({
    DateTime? date,
    String? status,
    String? category,
  }) async {
    orderModel = ApiResponse<ManageOrderModel?>().loading();
    update();
    print(
      "-------HiveService().getValue(HiveService.userId)--->${HiveService().getValue(HiveService.userId).toString()}",
    );

    final response = await _apiService.get<ManageOrderModel?>(
      "${ApiEndpoints.allGroupedOrders}?status=$status&category=$category&date=${date == null ? "" : DateFormat('MM-dd-yyyy').format(date!)}'",
      parser: (data) => ManageOrderModel.fromJson(data),
    );

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
