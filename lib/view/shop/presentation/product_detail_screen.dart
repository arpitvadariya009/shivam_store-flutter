import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/widget/api_state_manage.dart';
import 'package:shivam_stores/core/widget/button_widget.dart';
import 'package:shivam_stores/core/widget/image.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';

import 'package:shivam_stores/view/home/controller/home_controller.dart';
import 'package:shivam_stores/view/shop/controller/product_detail_controller.dart';
import 'package:shivam_stores/view/shop/model/product_detail_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: Container(),
        leadingWidth: 0,
        toolbarHeight: 40,
        backgroundColor: Get.find<ProductDetailController>().bgColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: cText(
                  value: Get.find<ProductDetailController>().title,
                  fontSize: 20,
                  color:
                      Get.find<ProductDetailController>().textColor ??
                      AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.clip,
                ),
              ),
              Flexible(
                child: cText(
                  value: 'S H I V A M',
                  fontSize: 20,
                  color:
                      Get.find<ProductDetailController>().textColor ??
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
            Get.find<ProductDetailController>().title.contains("FAVORITE") ||
                    Get.find<ProductDetailController>().title.contains("CART")
                ? BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Get.find<ProductDetailController>().title.contains("CART")
                          ? AppColors.blue004037CColor
                          : AppColors.yellow394002CColor,
                      AppColors.blackColor,
                    ],

                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                )
                : null,
        child: GetBuilder<ProductDetailController>(
          builder: (c) {
            return PageView.builder(
              controller: PageController(initialPage: c.index ?? 0),
              scrollDirection: Axis.horizontal,
              itemCount: c.categoriesModel?.data?.length,
              itemBuilder: (context, index) {
                final product = c.categoriesModel?.data?[index];
                return SizedBox(
                  width: width,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: double.infinity,
                        child: netWorkImage(
                          imageUrl: product?.image ?? "",
                          fit: BoxFit.contain,
                        ),
                      ),
                      // Right Control Panel
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ListView(
                                  children: [
                                    for (
                                      int i = 0;
                                      i < (product?.variants ?? []).length;
                                      i++
                                    ) ...[
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: AppColors.darkGreyColor,
                                          ),
                                        ),

                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,

                                          children: [
                                            AppSpacing.w10,
                                            cText(
                                              value:
                                                  product?.variants?[i].name ??
                                                  "",
                                              color: AppColors.whiteColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                            ),

                                            GestureDetector(
                                              onTap: () {
                                                if (product
                                                        ?.variants?[i]
                                                        .available ==
                                                    true) {
                                                  if (product!
                                                          .variants![i]
                                                          .qty !=
                                                      0) {
                                                    product.variants![i].qty =
                                                        (product
                                                                .variants![i]
                                                                .qty ??
                                                            0) -
                                                        (product.setSize ?? 0);
                                                    c.addToCart(
                                                      varinat:
                                                          product.variants?[i],
                                                      productCode:
                                                          product.code ?? "",
                                                      productId:
                                                          product.id ?? "",
                                                      increment:
                                                          '-${product.setSize ?? "0"}',
                                                    );
                                                    c.update();
                                                  }
                                                }
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                color: Colors.transparent,
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.remove,
                                                  color: AppColors.redColor,
                                                ),
                                              ),
                                            ),

                                            Flexible(
                                              child: Center(
                                                child: cText(
                                                  value:
                                                      product
                                                                  ?.variants?[i]
                                                                  .available ==
                                                              true
                                                          ? (product!
                                                                      .variants![i]
                                                                      .qty ??
                                                                  0)
                                                              .toString()
                                                          : 'N/A',
                                                  color: AppColors.whiteColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                  textAlign: TextAlign.center,

                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),

                                            GestureDetector(
                                              onTap: () {
                                                if (product
                                                        ?.variants?[i]
                                                        .available ==
                                                    true) {
                                                  product?.variants![i].qty =
                                                      (product
                                                              .variants![i]
                                                              .qty ??
                                                          0) +
                                                      (product.setSize ?? 0);

                                                  c.addToCart(
                                                    varinat:
                                                        product?.variants?[i],
                                                    productCode:
                                                        product?.code ?? "",
                                                    increment:
                                                        (product?.setSize ??
                                                                "0")
                                                            .toString(),
                                                    productId:
                                                        product?.id ?? "",
                                                  );
                                                  c.update();
                                                }
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                color:
                                                    product
                                                                    ?.variants?[i]
                                                                    .available ==
                                                                true &&
                                                            (product!
                                                                        .variants![i]
                                                                        .qty ??
                                                                    0) >
                                                                0
                                                        ? AppColors
                                                            .powderPurpleColor
                                                        : AppColors
                                                            .darkGreyColor,
                                                child: Icon(
                                                  Icons.add,
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      AppSpacing.h10,
                                    ],
                                  ],
                                ),
                              ),
                              AppSpacing.h5,

                              ButtonWidget(
                                onTap: () {
                                  product?.isFavorite =
                                      !(product.isFavorite ?? false);
                                  c.addToFavorite(
                                    productId: product?.id ?? "",
                                    isFavorite: product?.isFavorite ?? false,
                                  );
                                  c.update();
                                },
                                title:
                                    product?.type == 0
                                        ? "NEW"
                                        : product?.type == 1
                                        ? "TRENDING"
                                        : product?.type == 2
                                        ? "EVER GREEN"
                                        : product?.type == 3
                                        ? "Extra 5% Discount"
                                        : product?.type == 4
                                        ? "PREMIUM"
                                        : "",
                                leadingWidget: SvgPicture.asset(
                                  Get.find<ProductDetailController>().title
                                              .contains("FAVORITE") ||
                                          product?.isFavorite == true
                                      ? "assets/image/star_fill.svg"
                                      : "assets/image/star.svg",
                                ),
                                textcolor: AppColors.whiteColor,
                                fontWeight: FontWeight.w900,
                                borderRadius: 0,
                                fontSize: 20,
                                image:
                                    product?.type == 4
                                        ? DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/image/button_bg.png',
                                          ),
                                        )
                                        : null,
                                gradient:
                                    product?.type == 0
                                        ? LinearGradient(
                                          colors: [
                                            AppColors.blackColor,
                                            AppColors.lightRedColor.withOpacity(
                                              0.60,
                                            ),
                                            AppColors.yellowFDF507Color
                                                .withOpacity(0.60),
                                            AppColors.pinkF208ACColor
                                                .withOpacity(0.40),
                                            AppColors.blue0800FFCColor
                                                .withOpacity(0.40),
                                            AppColors.green2AFF00CColor
                                                .withOpacity(0.40),
                                            AppColors.teal04FFCDCColor
                                                .withOpacity(0.60),
                                          ],
                                          stops: [
                                            0.18,
                                            0.42,
                                            0.55,
                                            0.70,
                                            0.79,
                                            0.90,
                                            1,
                                          ],
                                        )
                                        : product?.type == 1
                                        ? LinearGradient(
                                          colors: [
                                            AppColors.blackColor,
                                            AppColors.blackColor,
                                            AppColors.buttonBB1515Color,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                        : product?.type == 2
                                        ? LinearGradient(
                                          colors: [
                                            AppColors.blackColor,
                                            AppColors.blackColor,
                                            AppColors.button009E15Color,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                        : product?.type == 3
                                        ? LinearGradient(
                                          colors: [
                                            AppColors.blackColor,
                                            AppColors.blackColor,
                                            AppColors.button2C1EEFColor,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                        : null,
                              ),
                              AppSpacing.h24,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuantityRow(
    String label,
    String value, {
    required void Function() onRemoveTap,
    required void Function() onAddTap,
  }) {
    return Row(
      children: [
        cText(
          value: label,
          color: AppColors.whiteColor,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        AppSpacing.w10,
        _buildCounter(
          value: value,
          onAddTap: onAddTap,
          onRemoveTap: onRemoveTap,
        ),
      ],
    );
  }

  Widget _buildCounter({
    required String value,
    required void Function() onRemoveTap,
    required void Function() onAddTap,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.whiteColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButtonWidget(
              onTap: onRemoveTap,
              icon: Icons.remove,
              borderRadius: 30,
              size: 30,
              iconColor: AppColors.redColor,
              bgColor: AppColors.whiteColor,
            ),
            cText(value: value, color: AppColors.whiteColor),
            IconButtonWidget(
              onTap: onAddTap,
              icon: Icons.add,
              borderRadius: 30,
              size: 30,
              iconColor: AppColors.blackColor,
              bgColor:
                  value == "0" || value == "N/A"
                      ? AppColors.darkGreyColor
                      : AppColors.powderPurpleColor,
            ),
          ],
        ),
      ),
    );
  }
}
