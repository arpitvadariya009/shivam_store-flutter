import 'package:get/get.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/orders/model/order_model.dart';

class OrdersController extends GetxController {
  final ApiService _apiService = ApiService.instance;
  ApiResponse<OrderModel?> orderModel = ApiResponse<OrderModel?>();
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
}
