import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/api_state_manage.dart';
import 'package:shivam_stores/core/widget/button_widget.dart';
import 'package:shivam_stores/core/widget/image.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_form_field.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/view/cart/controller/cart_controller.dart';
import 'package:shivam_stores/view/cart/model/cart_model.dart';
import 'package:shivam_stores/view/manage_order/controller/manage_order_controller.dart';
import 'package:shivam_stores/view/shop/presentation/shop_detail_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (c) {
        return Scaffold(
          resizeToAvoidBottomInset: true, // Add this line

          backgroundColor: Colors.transparent,
          appBar: AppBar(
            surfaceTintColor:
                c.apiName != null
                    ? AppColors.button2C0203Color
                    : AppColors.blue92FFFBColor,
            leading: Container(),
            leadingWidth: 0,
            toolbarHeight: 20,
            backgroundColor:
                c.apiName != null
                    ? AppColors.button2C0203Color
                    : AppColors.blue92FFFBColor,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: cText(
                      value:
                          c.apiName != null
                              ? 'MANAGE ORDERS / ${c.name} '
                              : 'CART',
                      fontSize: 14,
                      color:
                          c.apiName != null
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Flexible(
                    child: cText(
                      value: 'S H I V A M',
                      fontSize: 16,
                      color:
                          c.apiName != null
                              ? AppColors.whiteColor
                              : AppColors.blackColor,

                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: ApiStateWidget<CartModel?>(
            response: c.cartModel,
            dataBuilder:
                (data) =>
                    data?.success == false &&
                            data!.message.toString().contains('empty')
                        ? Center(
                          child: cText(
                            value: data.message ?? "",
                            color: AppColors.whiteColor,
                          ),
                        )
                        : Stack(
                          children: [
                            Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient:
                                    c.apiName != null
                                        ? LinearGradient(
                                          colors: [
                                            AppColors.button2C0203Color,
                                            AppColors.blackColor,
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        )
                                        : LinearGradient(
                                          colors: [
                                            AppColors.blue004037CColor,
                                            AppColors.blackColor,
                                          ],

                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: MasonryGridView.count(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 16,
                                      ),
                                      itemCount: data?.cart?.length,
                                      itemBuilder: (context, index) {
                                        final cartData = data?.cart?[index];
                                        final isVideo =
                                            cartData?.mediaType == "video";

                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                              AppRoutes.kProductDetailScreen,
                                              arguments: {
                                                'index': index,

                                                'id': cartData?.id ?? "",
                                                'title':
                                                    c.apiName != null
                                                        ? 'MANAGE ORDERS / ${c.name}'
                                                        : "CART",
                                                'bgColor':
                                                    c.apiName != null
                                                        ? AppColors
                                                            .button2C0203Color
                                                        : AppColors
                                                            .powderBlueColor,
                                                'textColor':
                                                    c.apiName != null
                                                        ? AppColors.whiteColor
                                                        : AppColors.blackColor,
                                                'variants': cartData?.variants,
                                                'cartdata': data?.cart,

                                                'categoryId':
                                                    cartData?.categoryId ?? '',
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.35,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child:
                                                  isVideo
                                                      ? VideoPlayerWidget(
                                                        url:
                                                            cartData?.media ??
                                                            "",
                                                      )
                                                      : netWorkImage(
                                                        imageUrl:
                                                            cartData?.media ??
                                                            "",
                                                      ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  Expanded(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                          80,
                                      padding: EdgeInsets.all(10),

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.whiteColor.withOpacity(
                                          0.2,
                                        ),
                                      ),

                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                c.tapNotes = true;
                                                c.update();
                                              },
                                              child: textFormField(
                                                enabled: false,
                                                controller: c.noteTXTController,
                                                hintText: 'NOTE:',
                                                textColor: AppColors.whiteColor,
                                                minLines: 30,
                                                fillColor:
                                                    c.status != null
                                                        ? AppColors
                                                            .black1A0000Color
                                                        : AppColors
                                                            .cartTxtFiledColor
                                                            .withOpacity(0.4),
                                                hintColor: AppColors.whiteColor,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      horizontal:
                                                          Get.width * 0.01,
                                                      vertical:
                                                          Get.width * 0.01,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          AppSpacing.h10,
                                          if (c.status != null)
                                            Row(
                                              spacing: 10,

                                              children: [
                                                AppSpacing.w10,
                                                Expanded(
                                                  child: ButtonWidget(
                                                    onTap: () async {
                                                      Get.find<ManageOrderController>().updateOrderStatus(
                                                        hideApi: true,
                                                        orderId:
                                                            c.orderId ?? "",
                                                        status: "1",
                                                        context: context,
                                                        category:
                                                            Get.find<ManageOrderController>()
                                                                        .buttonIndex ==
                                                                    3
                                                                ? Get.find<
                                                                      ManageOrderController
                                                                    >()
                                                                    .selectedCategoryName
                                                                : null,
                                                        statusFilter:
                                                            Get.find<ManageOrderController>()
                                                                        .buttonIndex ==
                                                                    2
                                                                ? '0'
                                                                : '',

                                                        date:
                                                            Get.find<ManageOrderController>()
                                                                        .buttonIndex ==
                                                                    0
                                                                ? DateTime.now()
                                                                : Get.find<
                                                                          ManageOrderController
                                                                        >()
                                                                        .buttonIndex ==
                                                                    1
                                                                ? DateTime.now()
                                                                    .subtract(
                                                                      const Duration(
                                                                        days: 1,
                                                                      ),
                                                                    )
                                                                : null,
                                                      );
                                                    },
                                                    title:
                                                        Strings.kInProcess
                                                            .toUpperCase(),
                                                    borderRadius: 10,

                                                    bgColor:
                                                        AppColors.darkGreyColor,
                                                    textcolor:
                                                        AppColors
                                                            .black1E1E1EColor,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        AppColors
                                                            .yellowD2A800Color,
                                                        AppColors.whiteColor,
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                Expanded(
                                                  child: ButtonWidget(
                                                    onTap: () async {
                                                      Get.find<ManageOrderController>().updateOrderStatus(
                                                        orderId:
                                                            c.orderId ?? "",
                                                        hideApi: true,

                                                        status: "2",
                                                        context: context,
                                                        category:
                                                            Get.find<ManageOrderController>()
                                                                        .buttonIndex ==
                                                                    3
                                                                ? Get.find<
                                                                      ManageOrderController
                                                                    >()
                                                                    .selectedCategoryName
                                                                : null,
                                                        statusFilter:
                                                            Get.find<ManageOrderController>()
                                                                        .buttonIndex ==
                                                                    3
                                                                ? '0'
                                                                : '',

                                                        date:
                                                            Get.find<ManageOrderController>()
                                                                        .buttonIndex ==
                                                                    1
                                                                ? DateTime.now()
                                                                : Get.find<
                                                                          ManageOrderController
                                                                        >()
                                                                        .buttonIndex ==
                                                                    2
                                                                ? DateTime.now()
                                                                    .subtract(
                                                                      const Duration(
                                                                        days: 1,
                                                                      ),
                                                                    )
                                                                : null,
                                                      );
                                                    },
                                                    title:
                                                        Strings.kDone
                                                            .toUpperCase(),
                                                    borderRadius: 10,
                                                    // bgColor:
                                                    //     AppColors.darkGreyColor,
                                                    textcolor:
                                                        AppColors
                                                            .black1E1E1EColor,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        AppColors
                                                            .green066E00Color,
                                                        AppColors
                                                            .greenD0FFBFColor,
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                AppSpacing.w10,
                                              ],
                                            )
                                          // else if (c.status?.toUpperCase() ==
                                          //     Strings.kInProcess.toUpperCase())
                                          //   ButtonWidget(
                                          //     onTap: () async {
                                          //       Get.find<ManageOrderController>().updateOrderStatus(
                                          //         hideApi: true,
                                          //         orderId: c.orderId ?? "",
                                          //         status: "2",
                                          //         context: context,
                                          //         category:
                                          //             Get.find<ManageOrderController>()
                                          //                         .buttonIndex ==
                                          //                     3
                                          //                 ? Get.find<
                                          //                       ManageOrderController
                                          //                     >()
                                          //                     .selectedCategoryName
                                          //                 : null,
                                          //         statusFilter:
                                          //             Get.find<ManageOrderController>()
                                          //                         .buttonIndex ==
                                          //                     2
                                          //                 ? '0'
                                          //                 : '',
                                          //         date:
                                          //             Get.find<ManageOrderController>()
                                          //                         .buttonIndex ==
                                          //                     0
                                          //                 ? DateTime.now()
                                          //                 : Get.find<
                                          //                           ManageOrderController
                                          //                         >()
                                          //                         .buttonIndex ==
                                          //                     1
                                          //                 ? DateTime.now()
                                          //                     .subtract(
                                          //                       const Duration(
                                          //                         days: 1,
                                          //                       ),
                                          //                     )
                                          //                 : null,
                                          //       );
                                          //     },
                                          //     title: 'DONE',
                                          //     borderRadius: 10,
                                          //     gradient: LinearGradient(
                                          //       colors: [
                                          //         AppColors.purple5B0453CColor,
                                          //         AppColors.purpleAF049EColor,
                                          //       ],
                                          //     ),
                                          //   )
                                          // else
                                          //   Container()
                                          else
                                            Row(
                                              spacing: 10,
                                              children: [
                                                Expanded(
                                                  child: ButtonWidget(
                                                    onTap: () async {
                                                      showDialog(
                                                        context: context,

                                                        builder: (context) {
                                                          return Dialog(
                                                            backgroundColor:
                                                                AppColors
                                                                    .black1E1E1EColor,
                                                            child: SizedBox(
                                                              width:
                                                                  Get.width *
                                                                  0.5,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets.symmetric(
                                                                      vertical:
                                                                          20,
                                                                      horizontal:
                                                                          40,
                                                                    ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    cText(
                                                                      value:
                                                                          "Confirm Order",
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          AppColors
                                                                              .whiteColor,
                                                                    ),
                                                                    AppSpacing
                                                                        .h16,

                                                                    cText(
                                                                      value:
                                                                          "Are you sure you want to place this order?",

                                                                      fontSize:
                                                                          16,

                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      color:
                                                                          AppColors
                                                                              .whiteColor,
                                                                    ),

                                                                    AppSpacing
                                                                        .h16,

                                                                    Row(
                                                                      spacing:
                                                                          20,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,

                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        ButtonWidget(
                                                                          onTap:
                                                                              () => Navigator.pop(
                                                                                context,
                                                                                false,
                                                                              ),

                                                                          bgColor: AppColors.whiteColor.withOpacity(
                                                                            0.5,
                                                                          ),
                                                                          title:
                                                                              "Cancel",
                                                                        ),
                                                                        ButtonWidget(
                                                                          onTap: () async {
                                                                            await c.placeOder(
                                                                              context:
                                                                                  context,
                                                                            );
                                                                            await c.fetchCart();
                                                                          },

                                                                          bgColor:
                                                                              AppColors.blue0800FFCColor,

                                                                          title:
                                                                              "PLACE ORDER",
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    title: 'PLACE ORDER',
                                                    borderRadius: 10,
                                                    fontSize: 18,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        AppColors
                                                            .purple5B0453CColor,
                                                        AppColors
                                                            .purpleAF049EColor,
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                Expanded(
                                                  child: ButtonWidget(
                                                    onTap: () {
                                                      Get.toNamed(
                                                        AppRoutes.kOrdersScreen,
                                                      );
                                                    },
                                                    title: 'Order\nForm',
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    tralingWidget: Container(
                                                      padding: EdgeInsets.all(
                                                        5,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        gradient: LinearGradient(
                                                          colors: [
                                                            AppColors
                                                                .black1A0000Color,
                                                            AppColors
                                                                .blackColor,
                                                          ],
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                        "assets/image/comment.png",
                                                      ),
                                                    ),

                                                    fontSize: 15,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        AppColors.blackColor,
                                                        AppColors
                                                            .purpleAF049EColor,
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          // AppSpacing.h10,
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (c.tapNotes)
                              Positioned.fill(
                                child: GestureDetector(
                                  onTap: () {
                                    c.tapNotes = false;
                                    c.update();
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,

                                    padding: EdgeInsets.all(Get.height * 0.05),
                                    color: AppColors.blackColor.withOpacity(
                                      0.4,
                                    ),

                                    child: textFormField(
                                      controller: c.noteTXTController,
                                      hintText: 'Notes',
                                      maxLines: 1,
                                      onFieldSubmitted: (val) {
                                        c.tapNotes = false;
                                        c.update();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
          ),
        );
      },
    );
  }
}
