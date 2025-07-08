import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/widget/api_state_manage.dart';
import 'package:shivam_stores/core/widget/button_widget.dart';
import 'package:shivam_stores/core/widget/image.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/view/dashboard/controller/dashboard_controller.dart';
import 'package:shivam_stores/view/home/controller/home_controller.dart';
import 'package:shivam_stores/view/shop/controller/product_detail_controller.dart';
import 'package:shivam_stores/view/shop/model/product_detail_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black1E1E1EColor,
      body: GetBuilder<ProductDetailController>(
        builder: (c) {
          return ApiStateWidget<ProductsDetailModel?>(
            response: c.productsDetailModel,
            dataBuilder: (context) {
              final product = c.productsDetailModel.data?.data;
              return Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.all(8),
                      child: netWorkImage(
                        imageUrl: product?.image ?? "",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Right Control Panel
                  Expanded(
                    // flex: 2,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (
                            int i = 0;
                            i < (product?.variants ?? []).length;
                            i++
                          ) ...[
                            _buildQuantityRow(
                              product?.variants?[i].name ?? "",
                              product?.variants?[i].available == true
                                  ? (product!.variants![i].qty ?? 0).toString()
                                  : 'N/A',
                              onAddTap: () {
                                if (product?.variants?[i].available == true) {
                                  product?.variants![i].qty =
                                      (product.variants![i].qty ?? 0) +
                                      (product.setSize ?? 0);

                                  c.addToCart(
                                    varinat: product?.variants?[i],
                                    productCode: product?.code ?? "",
                                    increment: '1',
                                  );
                                  c.update();
                                }
                              },
                              onRemoveTap: () {
                                if (product?.variants?[i].available == true) {
                                  if (product!.variants![i].qty != 0) {
                                    product.variants![i].qty =
                                        (product.variants![i].qty ?? 0) -
                                        (product.setSize ?? 0);
                                    c.addToCart(
                                      varinat: product.variants?[i],
                                      productCode: product.code ?? "",
                                      increment: '-1',
                                    );
                                    c.update();
                                  }
                                }
                              },
                            ),
                            AppSpacing.h10,
                          ],

                          AppSpacing.h24,

                          ButtonWidget(
                            onTap: () {
                              Get.find<HomeController>().controller.pause();

                              Get.find<DashboardController>().currentPage = 1;
                              Get.offNamed(AppRoutes.kDashboardScreen);
                            },
                            title: "Check Orders",
                            textcolor: AppColors.blackColor,
                            bgColor: AppColors.greenColor,
                          ),
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
              iconColor: AppColors.blackColor,
              bgColor: AppColors.whiteColor,
            ),
            cText(value: value, color: AppColors.whiteColor),
            IconButtonWidget(
              onTap: onAddTap,
              icon: Icons.add,
              borderRadius: 30,
              size: 30,
              iconColor: AppColors.blackColor,
              bgColor: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
