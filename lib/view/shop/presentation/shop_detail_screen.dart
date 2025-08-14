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
import 'package:shivam_stores/view/shop/controller/shop_controller.dart';
import 'package:shivam_stores/view/shop/controller/shop_detail_controller.dart';
import 'package:shivam_stores/view/shop/model/product_detail_model.dart';

class ShopDetailScreen extends StatelessWidget {
  const ShopDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: Container(),
        leadingWidth: 0,
        toolbarHeight: 20,
        backgroundColor: Get.find<ShopDetailController>().bgColor,
        surfaceTintColor: Get.find<ShopDetailController>().bgColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: cText(
                  value: Get.find<ShopDetailController>().title ?? "",
                  fontSize: 14,
                  color:
                      Get.find<ShopDetailController>().textColor ??
                      AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.clip,
                ),
              ),
              Flexible(
                child: cText(
                  value: 'S H I V A M',
                  fontSize: 16,
                  color:
                      Get.find<ShopDetailController>().textColor ??
                      AppColors.whiteColor,

                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),

        centerTitle: true,
      ),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:
            Get.find<ShopDetailController>().title == "FAVORITE"
                ? BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.yellow394002CColor,
                      AppColors.blackColor,
                    ],

                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                )
                : null,
        child: GetBuilder<ShopDetailController>(
          builder: (c) {
            return ApiStateWidget<ProductsDetailModel?>(
              response: c.productsModel,
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
                      itemCount: data?.data?.length,
                      itemBuilder: (context, index) {
                        final product = data?.data?[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.kProductDetailScreen,
                              arguments: {
                                'index': index,
                                'id': product?.id ?? "",
                                'title':
                                    "${Get.find<ShopDetailController>().title == "FAVORITE" ? Get.find<ShopDetailController>().title : "${Get.find<ShopController>().title.toUpperCase()} / ${Get.find<ShopDetailController>().title} "} / ${product?.code ?? ""}",
                                // "${Get.find<ShopController>().title.toUpperCase()} / ${Get.find<ShopDetailController>().title} / ${product?.code ?? ""}",
                                'bgColor':
                                    Get.find<ShopDetailController>().title ==
                                            "FAVORITE"
                                        ? Get.find<ShopDetailController>()
                                            .bgColor
                                        : Colors.transparent,
                                'textColor':
                                    Get.find<ShopDetailController>().title ==
                                            "FAVORITE"
                                        ? Get.find<ShopDetailController>()
                                            .textColor
                                        : AppColors.whiteColor,
                              },
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.32,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: netWorkImage(imageUrl: product?.image ?? ""),
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
      ),
    );
  }
}
