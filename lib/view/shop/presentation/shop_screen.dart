import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: Strings.shopData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.kShopDetailScreen);
          },
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
                      Strings.shopData[index]['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              AppSpacing.h5,
              cText(
                value: Strings.shopData[index]['name'],
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
