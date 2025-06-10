import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/Strings.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      body: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.kDashboardScreen);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cText(
                      value: Strings.kVerification,
                      color: AppColors.textPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                    AppSpacing.h16,
                    cText(
                      value: Strings.kWellgetbacktoyoushortly,
                      color: AppColors.textPrimaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                    AppSpacing.h10,

                    cText(
                      value: Strings.kWeareverifyingyourstore,
                      color: AppColors.black505050Color,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              AppSpacing.w16,
              Flexible(child: Image.asset("assets/image/verifying.png")),
            ],
          ),
        ),
      ),
    );
  }
}
