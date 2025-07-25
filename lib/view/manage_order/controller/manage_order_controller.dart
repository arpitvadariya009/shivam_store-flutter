import 'package:get/get.dart';

class ManageOrderController extends GetxController {
  int buttonIndex = 0;
}

class ManageOrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageOrderController());
  }
}
