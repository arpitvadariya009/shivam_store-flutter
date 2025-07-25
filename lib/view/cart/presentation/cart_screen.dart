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

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        surfaceTintColor: AppColors.blue92FFFBColor,
        leading: Container(),
        leadingWidth: 0,
        toolbarHeight: 40,
        backgroundColor: AppColors.blue92FFFBColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: cText(
                  value: 'CART',
                  fontSize: 20,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.clip,
                ),
              ),
              Flexible(
                child: cText(
                  value: 'S H I V A M',
                  fontSize: 20,
                  color: AppColors.blackColor,

                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<CartController>(
        builder: (c) {
          return ApiStateWidget<CartModel?>(
            response: c.cartModel,
            dataBuilder:
                (data) => Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
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
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.kProductDetailScreen,
                                  arguments: {
                                    'id': cartData?.productId?.id ?? "",
                                    'title':
                                        "CART / ${cartData?.productId?.code ?? ""}",
                                    'bgColor': AppColors.powderBlueColor,
                                    'textColor': AppColors.blackColor,
                                    'variants': cartData?.productId?.variants,
                                  },
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: netWorkImage(
                                    imageUrl: cartData?.productId?.image ?? "",
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height - 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.powderPurpleColor,
                              width: 4,
                            ),
                          ),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView(
                                  padding: EdgeInsets.all(5),

                                  children: [
                                    for (
                                      int i = 0;
                                      i < (data?.cart ?? []).length;
                                      i++
                                    )
                                      Row(
                                        children: [
                                          Flexible(
                                            child: cText(
                                              value:
                                                  "(${(data?.cart ?? [])[i].productId?.code} -> ${((data?.cart ?? [])[i].productId?.variants ?? []).where((e) => e.qty != null && e.qty != 0).map((e) => "${e.name} - ${e.qty}").join(' / ')})",
                                              color: AppColors.whiteColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              AppSpacing.h10,
                              textFormField(
                                controller: c.noteTXTController,
                                hintText: 'NOTE:',
                                fillColor: AppColors.boxBgColor.withOpacity(
                                  0.5,
                                ),
                              ),
                              ButtonWidget(
                                onTap: () {
                                  Get.toNamed(AppRoutes.kOrdersScreen);
                                },
                                title: 'PLACE ORDER',
                                borderRadius: 10,
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.purple5B0453CColor,
                                    AppColors.purpleAF049EColor,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
