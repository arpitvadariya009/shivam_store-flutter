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
import 'package:shivam_stores/view/home/model/categories_model.dart';
import 'package:shivam_stores/view/shop/controller/shop_detail_controller.dart';

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
          value: Get.find<ShopDetailController>().title,
          fontSize: 20,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),

      body: GetBuilder<ShopDetailController>(
        builder: (c) {
          return ApiStateWidget<CategoriesModel?>(
            response: c.productsModel,
            dataBuilder: (data) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  return MasonryGridView.count(
                    crossAxisCount:
                        orientation == Orientation.landscape ? 4 : 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 10,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    itemCount: data?.data?.length,
                    itemBuilder: (context, index) {
                      final product = data?.data?[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.kProductDetailScreen,
                            arguments: {'id': product?.id ?? ""},
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.boxBgColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: netWorkImage(
                                  imageUrl: product?.image ?? "",
                                ),
                              ),
                              AppSpacing.h5,
                              cText(
                                value: product?.code ?? "",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
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
