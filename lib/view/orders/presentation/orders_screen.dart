import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/button_widget.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/view/orders/controller/orders_controller.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      builder: (c) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < 3; i++)
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          c.currentPage = i;
                          c.update();
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: 35,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 3,
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color:
                                c.currentPage == i
                                    ? AppColors.black1E1E1EColor
                                    : AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10),

                            boxShadow: [
                              BoxShadow(
                                color: AppColors.blackColor.withOpacity(0.25),
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),

                          child: cText(
                            value: Strings.kOrderStatus[i],
                            minFontSize: 10,
                            maxFontSize: 10,

                            color:
                                c.currentPage == i
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                itemCount: Strings.shopData.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.unselectedIconColor),
                    ),

                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/image/order.svg',
                                color: AppColors.lightGreyColor,
                              ),

                              AppSpacing.w10,
                              Flexible(
                                child: cText(
                                  value: 'Today , 18 May, 2025',
                                  color: AppColors.lightGreyColor,
                                  fontWeight: FontWeight.w600,

                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: AppColors.unselectedIconColor,
                          height: 25,
                        ),
                        SizedBox(
                          height: 100,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    height: 100,

                                    Strings.shopData[index]['image'],

                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              AppSpacing.w16,
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    cText(
                                      value: 'Lipstick - 1006',
                                      color: AppColors.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    AppSpacing.h3,

                                    cText(
                                      value: '+2 other Products',
                                      color: AppColors.silver888888Color,
                                      fontSize: 10,
                                    ),
                                    AppSpacing.h3,

                                    cText(
                                      value: 'Total Shopping',
                                      color: AppColors.silver888888Color,
                                      fontSize: 10,
                                    ),
                                    AppSpacing.h7,

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

                                      children: [
                                        cText(
                                          value: '₹ 15600.00',
                                          color: AppColors.blackColor,
                                          fontSize: 10,

                                          fontWeight: FontWeight.w600,
                                        ),
                                        AppSpacing.w10,
                                        Flexible(
                                          child: ButtonWidget(
                                            onTap: () {},
                                            height: 30,
                                            width: 90,
                                            fontSize: 8,
                                            borderRadius: 8,
                                            title:
                                                c.currentPage == 0
                                                    ? Strings.kTrackStatus
                                                    : Strings.kOrderStatus[c
                                                        .currentPage],
                                            bgColor:
                                                c.currentPage == 2
                                                    ? AppColors.darkRedColor
                                                    : AppColors.darkGreenColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
