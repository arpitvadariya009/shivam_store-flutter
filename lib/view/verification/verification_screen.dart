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
      backgroundColor: Colors.transparent, // ✅ Important
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: GestureDetector(
        onTap: () {
          // Get.offAllNamed(AppRoutes.kHomeScreen);
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cText(
                      value: Strings.kVerification.toUpperCase(),
                      color: AppColors.whiteColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        cText(
                          value: Strings.kWellgetbacktoyoushortly,
                          color: AppColors.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.start,
                        ),

                        cText(
                          value: Strings.kWeareverifyingyourstore,
                          color: AppColors.whiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.w16,
              Flexible(
                child: Image.asset(
                  "assets/image/verifying.png",
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
