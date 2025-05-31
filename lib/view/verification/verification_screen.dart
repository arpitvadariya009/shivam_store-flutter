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
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        leading: Container(),
        elevation: 0,
        title: cText(
          value: Strings.kVerifying,
          fontSize: 20,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),

      body: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.kDashboardScreen);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              cText(
                value: Strings.kWellgetbacktoyoushortly,
                color: AppColors.textPrimaryColor,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              AppSpacing.h32,
              Flexible(child: Image.asset("assets/image/verifying.png")),
              AppSpacing.h32,
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
      ),
    );
  }
}
