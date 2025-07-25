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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,

        leading: Container(),
        leadingWidth: 0,
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: cText(
                  value: Get.find<ShopController>().title.toUpperCase(),
                  fontSize: 20,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.clip,
                ),
              ),
              Flexible(
                child: cText(
                  value: 'S H I V A M',
                  fontSize: 20,
                  color: AppColors.whiteColor,

                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
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
                      horizontal: 60,
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
                              'bgColor': AppColors.transparentColor,
                            },
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(5),

                          color: AppColors.whiteColor.withOpacity(0.2),

                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: height * 0.25,
                                child: netWorkImage(
                                  imageUrl: subCatData?.image ?? "",
                                ),
                              ),

                              Container(
                                width: double.infinity,
                                color: AppColors.blackColor,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: cText(
                                  value: (subCatData?.name ?? "").toUpperCase(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.whiteColor,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
