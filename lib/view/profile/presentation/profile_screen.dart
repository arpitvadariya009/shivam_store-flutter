import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/button_widget.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/auth/model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserData userData = UserData.fromJson(
      jsonDecode(HiveService().getValue(HiveService.userData)),
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        surfaceTintColor: AppColors.powderGreenColor,
        leading: Container(),
        leadingWidth: 0,
        toolbarHeight: 40,
        backgroundColor: AppColors.powderGreenColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: cText(
                  value: 'PROFILE',
                  fontSize: 20,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.clip,
                ),
              ),
              Flexible(
                child: cText(
                  value: 'S H I V A M',
                  fontSize: 20,
                  color: AppColors.blackColor,

                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.black00210AColor, AppColors.blackColor],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            Container(
              height: 120,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.whiteColor),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.textFieldBgColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset('assets/image/account.png'),
                  ),
                  AppSpacing.w16,
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        cText(
                          value: userData.firmName ?? "",
                          color: AppColors.whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        AppSpacing.h5,

                        Row(
                          children: [
                            Image.asset(
                              'assets/image/location.png',
                              color: AppColors.whiteColor,
                            ),
                            AppSpacing.w4,
                            cText(
                              value: userData.city ?? "",
                              fontSize: 10,

                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                        AppSpacing.h5,
                        Row(
                          children: [
                            Image.asset(
                              'assets/image/call.png',
                              color: AppColors.whiteColor,
                            ),

                            AppSpacing.w4,

                            cText(
                              value: userData.mobile ?? "",
                              color: AppColors.whiteColor,
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.h16,
            Row(
              children: [
                Expanded(
                  child: ButtonWidget(
                    onTap: () {
                      log('-----------Orders Button Tapped');

                      Get.offNamed(AppRoutes.kManageOrderScreen);
                    },
                    title:
                        HiveService().getValue(HiveService.isStaff) == true
                            ? Strings.kManageOrders
                            : Strings.kOrders,
                    textcolor: AppColors.blackColor,
                    bgColor: AppColors.whiteColor,
                    border: Border.all(color: AppColors.blackColor),
                  ),
                ),
                if (HiveService().getValue(HiveService.isStaff) != true) ...[
                  AppSpacing.w10,
                  Expanded(
                    child: ButtonWidget(
                      onTap: () {
                        // Get.find<HomeController>().controller.play();

                        // Get.find<DashboardController>().currentPage = 0;
                        // Get.find<DashboardController>().update();

                        // Get.offNamed(AppRoutes.kDashboardScreen);
                      },
                      title: Strings.kProducts,
                      textcolor: AppColors.blackColor,
                      bgColor: AppColors.whiteColor,
                      border: Border.all(color: AppColors.blackColor),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
