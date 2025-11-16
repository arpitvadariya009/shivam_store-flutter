import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/back_ground_service.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _activeIndex = 0;
  final int _count = 4;
  Timer? _timer;
  final Duration _delay = const Duration(seconds: 1);

  void _startAutoPlay() {
    _timer = Timer.periodic(_delay, (_) {
      setState(() {
        _activeIndex = (_activeIndex + 1) % _count;
      });
    });
  }

  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  void initState() {
    _startAutoPlay();
    Future.delayed(Duration(seconds: 4), () {
      if (HiveService().getValue(HiveService.userId) == null) {
        Get.offAllNamed(AppRoutes.kLoginScreen);
      } else {
        if (HiveService().getValue(HiveService.isverified)) {
          Get.offAllNamed(AppRoutes.kHomeScreen);
        } else {
          Get.offAllNamed(AppRoutes.kVerificationScreen);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.navyBlueColor, AppColors.darkBlueColor],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: SvgPicture.asset(
                    "assets/image/splash_image.svg",
                    height: height * 0.5,
                  ),
                ),

                AppSpacing.h32,

                AnimatedSmoothIndicator(
                  activeIndex: _activeIndex,
                  count: _count,

                  effect: SwapEffect(
                    dotWidth: 12,
                    dotHeight: 12,
                    type: SwapType.yRotation,
                    spacing: 10,
                    dotColor: AppColors.softOrangeColor,
                    activeDotColor: AppColors.softPinkColor,
                  ),
                ),

                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     CircleAvatar(
                //       radius: 5,
                //       backgroundColor: AppColors.softOrangeColor,
                //     ),

                //     AppSpacing.w24,
                //     CircleAvatar(
                //       radius: 5,
                //       backgroundColor: AppColors.softYellowColor,
                //     ),
                //     AppSpacing.w24,
                //     CircleAvatar(
                //       radius: 5,
                //       backgroundColor: AppColors.softPinkColor,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
