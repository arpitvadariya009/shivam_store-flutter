import 'package:get/get.dart';

class HomeController extends GetxController {}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
