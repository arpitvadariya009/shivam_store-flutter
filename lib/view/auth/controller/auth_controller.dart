import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController firmNameTXTController = TextEditingController();
  TextEditingController cityTXTController = TextEditingController();
  TextEditingController mobileTXTController = TextEditingController(
    text: "+91 ",
  );
  TextEditingController passwordTXTController = TextEditingController();
  bool isPasswordValid = false;
  bool isPivacyValid = false;
}

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthController());
  }
}
