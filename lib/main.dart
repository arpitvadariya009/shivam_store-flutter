import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/back_ground_service.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:no_screenshot/no_screenshot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kDebugMode) {
    await NoScreenshot.instance.screenshotOff();
  }

  await BackgroundLocation.ensurePermissionsReady(requestIfNeeded: false);
  await BackgroundLocation.getLocationInBackground();
  await BackgroundLocation.requestPermission();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  await HiveService().init();

  Get.put<ApiService>(ApiService(), permanent: true);

  runApp(const MyApp());
  // runApp(
  //   DevicePreview(
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 200),
      theme: ThemeData(fontFamily: "Poppins"),
      initialRoute: AppRoutes.kSplashScreen,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.navyBlueColor, AppColors.darkBlueColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
