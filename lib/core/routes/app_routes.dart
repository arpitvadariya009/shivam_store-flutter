import 'package:get/get.dart';
import 'package:shivam_stores/view/auth/controller/auth_controller.dart';
import 'package:shivam_stores/view/auth/presentation/login_screen.dart';
import 'package:shivam_stores/view/auth/presentation/register_screen.dart';
import 'package:shivam_stores/view/cart/controller/cart_controller.dart';
import 'package:shivam_stores/view/cart/presentation/cart_screen.dart';

import 'package:shivam_stores/view/home/controller/home_controller.dart';
import 'package:shivam_stores/view/home/presentation/home_screen.dart';
import 'package:shivam_stores/view/manage_order/controller/manage_order_controller.dart';
import 'package:shivam_stores/view/manage_order/presentation/manage_order_screen.dart';
import 'package:shivam_stores/view/orders/controller/orders_controller.dart';
import 'package:shivam_stores/view/orders/presentation/orders_screen.dart';
import 'package:shivam_stores/view/profile/presentation/profile_screen.dart';

import 'package:shivam_stores/view/shop/controller/product_detail_controller.dart';
import 'package:shivam_stores/view/shop/controller/shop_controller.dart';
import 'package:shivam_stores/view/shop/controller/shop_detail_controller.dart';
import 'package:shivam_stores/view/shop/presentation/product_detail_screen.dart';
import 'package:shivam_stores/view/shop/presentation/shop_detail_screen.dart';
import 'package:shivam_stores/view/shop/presentation/shop_screen.dart';
import 'package:shivam_stores/view/splash/splash_screen.dart';
import 'package:shivam_stores/view/verification/verification_screen.dart';

class AppRoutes {
  static const kSplashScreen = '/SplashScreen';
  static const kRegisterScreen = '/RegisterScreen';
  static const kLoginScreen = '/LoginScreen';
  static const kVerificationScreen = '/VerificationScreen';
  static const kHomeScreen = '/HomeScreen';

  static const kShopDetailScreen = '/ShopDetailScreen';
  static const kCartScreen = '/CartScreen';
  static const kProductDetailScreen = '/ProductDetailScreen';
  static const kShopScreen = '/ShopScreen';
  static const kProfileScreen = '/ProfileScreen';
  static const kOrdersScreen = '/OrdersScreen';
  static const kManageOrderScreen = '/ManageOrderScreen';
}

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.kSplashScreen, page: () => const SplashScreen()),
    GetPage(
      name: AppRoutes.kRegisterScreen,
      page: () => const RegisterScreen(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: AppRoutes.kLoginScreen,
      page: () => const LoginScreen(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: AppRoutes.kVerificationScreen,
      page: () => const VerificationScreen(),
    ),

    GetPage(
      name: AppRoutes.kShopDetailScreen,
      page: () => const ShopDetailScreen(),
      binding: ShopDetailBindings(),
    ),
    GetPage(
      name: AppRoutes.kProductDetailScreen,
      page: () => const ProductDetailScreen(),
      binding: ProductDetailBindings(),
    ),
    GetPage(
      name: AppRoutes.kShopScreen,
      page: () => const ShopScreen(),
      binding: ShopBindings(),
    ),
    GetPage(
      name: AppRoutes.kHomeScreen,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: AppRoutes.kOrdersScreen,
      page: () => const OrdersScreen(),
      binding: OrderBindings(),
    ),
    GetPage(name: AppRoutes.kProfileScreen, page: () => const ProfileScreen()),
    GetPage(
      name: AppRoutes.kCartScreen,
      page: () => const CartScreen(),
      binding: CartBindings(),
    ),
    GetPage(
      name: AppRoutes.kManageOrderScreen,
      page: () => const ManageOrderScreen(),
      binding: ManageOrderBindings(),
    ),
  ];
}
