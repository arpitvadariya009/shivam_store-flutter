import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/services/hive_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Future.delayed(Duration(seconds: 3), () {
    //   if (HiveService().getValue(HiveService.userId) == null) {
    //     Get.offAllNamed(AppRoutes.kRegisterScreen);
    //   } else {
    //     Get.offAllNamed(AppRoutes.kDashboardScreen);
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Conta(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/image/logo.svg"),
              AppSpacing.h50,
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: LinearProgressIndicator(color: AppColors.blackColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
