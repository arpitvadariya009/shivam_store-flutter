import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/widget/button_widget.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/view/shop/controller/category_controller.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      },
      child: Scaffold(
        backgroundColor: AppColors.black1E1E1EColor,
        body: GetBuilder<CategoryController>(
          builder: (c) {
            return Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/image/category_detail.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Right Control Panel
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildQuantityRow('A', 'N/A'),
                        const SizedBox(height: 10),
                        _buildQuantityRow('B', '6'),
                        const SizedBox(height: 10),
                        _buildQuantityRow('C', '6'),
                        const SizedBox(height: 10),
                        _buildQuantityRow('D', '6'),
                        const SizedBox(height: 10),
                        _buildQuantityRow('E', '6'),
                        AppSpacing.h16,

                        ButtonWidget(
                          onTap: () {},
                          title: 'Quantity : 24pcs',
                          height: 40,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,

                          bgColor: AppColors.selectedButtonBgColor,
                        ),
                        AppSpacing.h10,

                        Row(
                          children: [
                            Flexible(
                              child: ButtonWidget(
                                onTap: () {},
                                title: "Add to Cart",
                                fontSize: 12,
                                height: 40,
                                fontWeight: FontWeight.w500,
                                bgColor: AppColors.whiteColor,
                                textcolor: AppColors.blackColor,
                              ),
                            ),

                            AppSpacing.w10,
                            IconButtonWidget(
                              onTap: () {},
                              borderRadius: 30,
                              size: 40,
                              icon: Icons.arrow_forward,
                              bgColor: AppColors.whiteColor,
                              iconColor: AppColors.blackColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuantityRow(String label, String value) {
    return Row(
      children: [
        cText(
          value: label,
          color: AppColors.whiteColor,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        AppSpacing.w10,
        _buildCounter(value),
      ],
    );
  }

  Widget _buildCounter(String value) {
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
              onTap: () {},
              icon: Icons.remove,
              borderRadius: 30,
              size: 30,
              iconColor: AppColors.blackColor,
              bgColor: AppColors.whiteColor,
            ),
            cText(value: value, color: AppColors.whiteColor),
            IconButtonWidget(
              onTap: () {},
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
