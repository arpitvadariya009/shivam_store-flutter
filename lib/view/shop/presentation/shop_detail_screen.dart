import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';

class ShopDetailScreen extends StatelessWidget {
  const ShopDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.blackColor,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        elevation: 0,
        title: cText(
          value: 'Earrings',
          fontSize: 20,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),

      body: GridView.builder(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.kCategoryDetailScreen);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.boxBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/image/${index + 1}.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  AppSpacing.h5,
                  cText(
                    value: '${1001 + index}',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
