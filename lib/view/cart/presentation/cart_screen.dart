import 'package:flutter/material.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/button_widget.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemCount: Strings.cartData.length,
      itemBuilder: (context, index) {
        final item = Strings.cartData[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,

                decoration: BoxDecoration(
                  color: AppColors.boxBgColor,

                  borderRadius: BorderRadius.circular(10),
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    Strings.cartData[0]['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AppSpacing.w10,
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          cText(
                            value: item['title'],
                            color: AppColors.blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          AppSpacing.h5,

                          cText(
                            value: "Set = ${item['set']}",
                            color: AppColors.blackColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          AppSpacing.h5,

                          cText(
                            value:
                                "Selected Design = ${item['selectedDesign']}",
                            color: AppColors.blackColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          AppSpacing.h5,
                          cText(
                            value: "Total Piece = ${item['totalPiece']}",
                            color: AppColors.blackColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.w10,

                    IconButtonWidget(
                      onTap: () {},
                      image: "assets/image/delete.png",
                      size: 40,
                      iconSize: 20,
                      borderRadius: 8,
                      iconColor: AppColors.darkRedColor,
                      bgColor: AppColors.darkRedColor.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
