import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/api_state_manage.dart';
import 'package:shivam_stores/core/widget/image.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/view/shop/controller/shop_controller.dart';
import 'package:shivam_stores/view/shop/model/sub_cat_model.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.whiteColor,
        leadingWidth: 140,
        leading: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.blackColor,
            ),
          ),
        ),

        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: cText(
          value: Get.find<ShopController>().title,
          fontSize: 20,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w600,
          overflow: TextOverflow.clip,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ShopController>(
        builder: (c) {
          return ApiStateWidget<SubCategoriesModel?>(
            response: c.subCategoriesModel,
            dataBuilder: (data) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  return MasonryGridView.count(
                    crossAxisCount:
                        orientation == Orientation.landscape ? 3 : 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 16,
                    ),
                    itemCount: data?.subCategories?.length,

                    itemBuilder: (context, index) {
                      final subCatData = data?.subCategories?[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.kShopDetailScreen,
                            arguments: {
                              'id': subCatData?.id ?? "",
                              'title': subCatData?.name ?? "",
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.unselectedIconColor,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 150,

                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.blackColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: netWorkImage(
                                    imageUrl: subCatData?.image ?? "",
                                  ),
                                ),
                              ),
                              AppSpacing.h5,
                              cText(
                                value: subCatData?.name ?? "",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
