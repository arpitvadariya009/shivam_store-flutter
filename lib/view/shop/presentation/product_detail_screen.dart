import 'dart:developer';

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
import 'package:shivam_stores/view/shop/presentation/shop_detail_screen.dart';

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
        toolbarHeight: 20,
        backgroundColor: Get.find<ProductDetailController>().bgColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: cText(
                  value: Get.find<ProductDetailController>().title,
                  fontSize: 14,
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
                  fontSize: 16,
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
                    Get.find<ProductDetailController>().title.contains(
                      "CART",
                    ) ||
                    Get.find<ProductDetailController>().title.contains(
                      "MANAGE ORDERS",
                    )
                ? BoxDecoration(
                  gradient: LinearGradient(
                    colors:
                        Get.find<ProductDetailController>().title.contains(
                              "MANAGE ORDERS",
                            )
                            ? [
                              AppColors.button2C0203Color,
                              AppColors.blackColor,
                            ]
                            : [
                              Get.find<ProductDetailController>().title
                                      .contains("CART")
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
                final isVideo = product?.mediaType == "video";
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: GestureDetector(
                        onDoubleTapDown: (details) {
                          c.doubleTapDetails = details; // Save tap position
                        },
                        onDoubleTap: () {
                          final controller = c.transformationController;
                          final position = c.doubleTapDetails?.localPosition;
                          const double zoomScale = 2.0;
                          if (controller.value != Matrix4.identity()) {
                            controller.value = Matrix4.identity();
                          } else {
                            final x = -position!.dx * (zoomScale - 1);
                            final y = -position.dy * (zoomScale - 1);
                            controller.value =
                                Matrix4.identity()
                                  ..translate(x, y)
                                  ..scale(zoomScale);
                          }
                        },
                        child: InteractiveViewer(
                          minScale: 0.5,

                          panEnabled: true, // Allow drag when zoomed
                          scaleEnabled: true, // Allow pinch zoom
                          maxScale: 4.0,

                          clipBehavior: Clip.none,
                          transformationController: c.transformationController,

                          child: SizedBox(
                            height: double.infinity,
                            child:
                                isVideo
                                    ? VideoPlayerWidget(
                                      url: product?.media ?? "",
                                      isPlayPuase: true,
                                      autoPlay: true,
                                    )
                                    : netWorkImage(
                                      imageUrl: product?.media ?? "",
                                      fit: BoxFit.contain,
                                    ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,

                                children: [
                                  for (
                                    int i = 0;
                                    i < (product?.variants ?? []).length;
                                    i++
                                  ) ...[
                                    Container(
                                      padding: EdgeInsets.only(left: 20),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.darkGreyColor,
                                        ),
                                      ),

                                      child:
                                          (c.title.contains('MANAGE ORDERS'))
                                              ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                spacing: 10,
                                                children: [
                                                  cText(
                                                    value:
                                                        product
                                                            ?.variants?[i]
                                                            .name ??
                                                        "",
                                                    color: AppColors.whiteColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                  ),

                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      color: Colors.transparent,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColors
                                                                .outoffStockColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: cText(
                                                      value:
                                                          (product!
                                                                      .variants![i]
                                                                      .qty ??
                                                                  0)
                                                              .toString(),
                                                      color:
                                                          AppColors.whiteColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      textAlign:
                                                          TextAlign.center,

                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),

                                                  GestureDetector(
                                                    onTap: () {
                                                      product
                                                          .variants?[i]
                                                          .available = !(product
                                                                  .variants?[i]
                                                                  .available ??
                                                              false);
                                                      c.outOfStock(
                                                        productId:
                                                            product.id ?? '',
                                                        variantId:
                                                            product
                                                                .variants?[i]
                                                                .id ??
                                                            '',
                                                        available:
                                                            product
                                                                .variants?[i]
                                                                .available ??
                                                            false,
                                                      );

                                                      c.update();
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      color:
                                                          product
                                                                      ?.variants?[i]
                                                                      .available ??
                                                                  false
                                                              ? AppColors
                                                                  .outoffStockColor
                                                              : AppColors
                                                                  .boxBgColor
                                                                  .withOpacity(
                                                                    0.2,
                                                                  ),
                                                      alignment:
                                                          Alignment.center,
                                                    ),
                                                  ),
                                                ],
                                              )
                                              : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,

                                                children: [
                                                  cText(
                                                    value:
                                                        product
                                                            ?.variants?[i]
                                                            .name ??
                                                        "",
                                                    color: AppColors.whiteColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                  ),

                                                  GestureDetector(
                                                    onTap: () {
                                                      log(
                                                        "------->minus ----->${product?.variants?[i].available}",
                                                      );
                                                      if (product
                                                              ?.variants?[i]
                                                              .available ==
                                                          true) {
                                                        if ((product!
                                                                    .variants![i]
                                                                    .qty ??
                                                                0) >
                                                            0) {
                                                          product
                                                              .variants![i]
                                                              .qty = (product
                                                                      .variants![i]
                                                                      .qty ??
                                                                  0) -
                                                              (product
                                                                      .variants?[i]
                                                                      .setSize ??
                                                                  0);
                                                          c.addToCart(
                                                            varinat:
                                                                product
                                                                    .variants?[i],
                                                            productCode:
                                                                product.code ??
                                                                "",
                                                            productId:
                                                                product.id ??
                                                                "",
                                                            increment:
                                                                -(product
                                                                        .variants?[i]
                                                                        .setSize ??
                                                                    0),
                                                          );
                                                          c.update();
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      color: Colors.transparent,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColors.redColor,
                                                      ),
                                                    ),
                                                  ),

                                                  Flexible(
                                                    child: cText(
                                                      value:
                                                          (c.title.contains(
                                                                'MANAGE ORDERS',
                                                              ))
                                                              ? (product!
                                                                          .variants![i]
                                                                          .qty ??
                                                                      0)
                                                                  .toString()
                                                              : product
                                                                      ?.variants?[i]
                                                                      .available ==
                                                                  true
                                                              ? (product!
                                                                          .variants![i]
                                                                          .qty ??
                                                                      0)
                                                                  .toString()
                                                              : 'N/A',
                                                      color:
                                                          AppColors.whiteColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      textAlign:
                                                          TextAlign.center,

                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),

                                                  GestureDetector(
                                                    onTap: () {
                                                      if (product
                                                              ?.variants?[i]
                                                              .available ==
                                                          true) {
                                                        product
                                                            ?.variants![i]
                                                            .qty = (product
                                                                    .variants![i]
                                                                    .qty ??
                                                                0) +
                                                            (product
                                                                    .variants?[i]
                                                                    .setSize ??
                                                                0);
                                                        log(
                                                          "-------product?.setSize --->${product?.variants?[i].setSize}",
                                                        );
                                                        c.addToCart(
                                                          varinat:
                                                              product
                                                                  ?.variants?[i],
                                                          productCode:
                                                              product?.code ??
                                                              "",
                                                          increment:
                                                              product
                                                                  ?.variants?[i]
                                                                  .setSize ??
                                                              0,
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
                                                          product?.variants?[i].available ==
                                                                      true &&
                                                                  (product!.variants![i].qty ??
                                                                          0) >
                                                                      0
                                                              ? AppColors
                                                                  .powderPurpleColor
                                                              : AppColors
                                                                  .darkGreyColor,
                                                      child: Icon(
                                                        Icons.add,
                                                        color:
                                                            AppColors
                                                                .blackColor,
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
                                if (product?.isFavorite == null ||
                                    product?.isFavorite == false) {
                                  product?.isFavorite = true;
                                } else {
                                  product?.isFavorite = false;
                                }
                                c.update();

                                c.addToFavorite(
                                  productId: product?.id ?? "",
                                  isFavorite: product?.isFavorite ?? false,
                                );
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
                                      : product?.type == 5
                                      ? "Add To Wish List"
                                      : product?.type == 6
                                      ? "Limited Stock"
                                      : "",
                              leadingWidget: SvgPicture.asset(
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
                                  product?.type == 0 || product?.type == 6
                                      ? LinearGradient(
                                        colors: [
                                          AppColors.blackColor,
                                          AppColors.lightRedColor.withOpacity(
                                            0.60,
                                          ),
                                          AppColors.yellowFDF507Color
                                              .withOpacity(0.60),
                                          AppColors.pinkF208ACColor.withOpacity(
                                            0.40,
                                          ),
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
                                      : product?.type == 5
                                      ? LinearGradient(
                                        colors: [
                                          AppColors.navyBlueColor,
                                          AppColors.darkBlueColor,
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      )
                                      : null,
                            ),
                            AppSpacing.h24,
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
