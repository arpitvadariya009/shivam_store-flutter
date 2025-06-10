import 'package:get/get.dart';
import 'package:shivam_stores/view/auth/controller/auth_controller.dart';
import 'package:shivam_stores/view/auth/presentation/login_screen.dart';
import 'package:shivam_stores/view/auth/presentation/register_screen.dart';
import 'package:shivam_stores/view/dashboard/controller/dashboard_controller.dart';
import 'package:shivam_stores/view/dashboard/presentation/dashboard_screen.dart';
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
  static const kDashboardScreen = '/DashboardScreen';
  static const kShopDetailScreen = '/ShopDetailScreen';
  static const kProductDetailScreen = '/ProductDetailScreen';
  static const kShopScreen = '/ShopScreen';
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
      name: AppRoutes.kDashboardScreen,
      page: () => const DashboardScreen(),
      binding: DashboardBindings(),
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
  ];
}
