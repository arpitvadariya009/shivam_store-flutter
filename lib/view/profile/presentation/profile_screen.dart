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
import 'package:shivam_stores/view/dashboard/controller/dashboard_controller.dart';
import 'package:shivam_stores/view/home/controller/home_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserData userData = UserData.fromJson(
      jsonDecode(HiveService().getValue(HiveService.userData)),
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.blackColor),
      ),
      child: ListView(
        children: [
          Container(
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.blackColor),
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
                        color: AppColors.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      AppSpacing.h5,

                      Row(
                        children: [
                          Image.asset('assets/image/location.png'),

                          AppSpacing.w4,
                          cText(
                            value: userData.city ?? "",
                            fontSize: 10,

                            color: AppColors.blackColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                      AppSpacing.h5,
                      Row(
                        children: [
                          Image.asset('assets/image/call.png'),

                          AppSpacing.w4,

                          cText(
                            value: userData.mobile ?? "",
                            color: AppColors.blackColor,
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

                    Get.find<HomeController>().controller.pause();

                    Get.find<DashboardController>().currentPage = 1;
                    Get.find<DashboardController>().update();
                    Get.offNamed(AppRoutes.kDashboardScreen);
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
                      Get.find<HomeController>().controller.play();

                      Get.find<DashboardController>().currentPage = 0;
                      Get.find<DashboardController>().update();

                      Get.offNamed(AppRoutes.kDashboardScreen);
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
    );
  }
}
