import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/view/cart/presentation/cart_screen.dart';
import 'package:shivam_stores/view/home/presentation/home_screen.dart';
import 'package:shivam_stores/view/orders/controller/orders_controller.dart';
import 'package:shivam_stores/view/orders/presentation/orders_screen.dart';
import 'package:shivam_stores/view/shop/presentation/shop_screen.dart';

class DashboardController extends GetxController {
  int currentPage = 0;
  final List<Widget> screens = [
    HomeScreen(),
    ShopScreen(),
    CartScreen(),
    OrdersScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
  }
}

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => OrdersController());
  }
}
