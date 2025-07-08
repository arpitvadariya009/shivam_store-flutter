import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shivam_stores/view/home/controller/home_controller.dart';
import 'package:shivam_stores/view/home/presentation/home_screen.dart';

import 'package:shivam_stores/view/orders/presentation/orders_screen.dart';
import 'package:shivam_stores/view/profile/presentation/profile_screen.dart';

class DashboardController extends GetxController {
  int currentPage = 0;
  final List<Widget> screens = [HomeScreen(), OrdersScreen(), ProfileScreen()];

  @override
  void onInit() {
    super.onInit();
  }
}

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
  }
}
