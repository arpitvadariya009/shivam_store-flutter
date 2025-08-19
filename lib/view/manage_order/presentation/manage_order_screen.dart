import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/api_state_manage.dart';
import 'package:shivam_stores/core/widget/button_widget.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/view/manage_order/controller/manage_order_controller.dart';
import 'package:shivam_stores/view/manage_order/model/manage_order_model.dart';

class ManageOrderScreen extends StatelessWidget {
  const ManageOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.button2C0203Color,
      appBar: AppBar(
        surfaceTintColor: AppColors.blackColor,

        leading: Container(),
        leadingWidth: 0,
        toolbarHeight: 20,
        backgroundColor: AppColors.blackColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: cText(
                  value: 'MANAGE ORDERS',
                  fontSize: 14,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.clip,
                ),
              ),
              Flexible(
                child: cText(
                  value: 'S H I V A M',
                  fontSize: 16,
                  color: AppColors.whiteColor,

                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<ManageOrderController>(
        builder: (c) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.button2C0203Color, AppColors.blackColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 10,
                      children: [
                        ButtonWidget(
                          onTap: () {
                            c.buttonIndex = 0;
                            c.fetchOrder(date: DateTime.now());
                            c.update();
                          },
                          title: 'TODAY',
                          width: 80,
                          height: 40,
                          textcolor:
                              c.buttonIndex == 0
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                          bgColor:
                              c.buttonIndex == 0
                                  ? AppColors.buttonFFAE00Color
                                  : AppColors.whiteColor.withOpacity(0.4),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),

                        ButtonWidget(
                          onTap: () {
                            c.buttonIndex = 1;
                            c.fetchOrder(
                              date: DateTime.now().subtract(
                                const Duration(days: 1),
                              ),
                            );

                            c.update();
                          },
                          title: 'YESTERDAY',
                          width: 100,
                          height: 40,
                          textcolor:
                              c.buttonIndex == 1
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                          bgColor:
                              c.buttonIndex == 1
                                  ? AppColors.buttonFFAE00Color
                                  : AppColors.whiteColor.withOpacity(0.4),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        AppSpacing.w32,

                        ButtonWidget(
                          onTap: () {
                            c.buttonIndex = 2;
                            c.fetchOrder(status: 'PENDING');
                            c.update();
                          },
                          title: 'PENDING',
                          width: 100,
                          height: 40,
                          textcolor:
                              c.buttonIndex == 2
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                          bgColor:
                              c.buttonIndex == 2
                                  ? AppColors.buttonFFAE00Color
                                  : AppColors.whiteColor.withOpacity(0.4),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        AppSpacing.w32,

                        ButtonWidget(
                          onTap: () {
                            c.buttonIndex = 3;
                            c.update();
                          },
                          title: 'COSMETIC',
                          width: 100,
                          height: 40,
                          textcolor:
                              c.buttonIndex == 3
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                          bgColor:
                              c.buttonIndex == 3
                                  ? AppColors.buttonFFAE00Color
                                  : AppColors.whiteColor.withOpacity(0.4),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),

                        ButtonWidget(
                          onTap: () {
                            c.buttonIndex = 4;
                            c.update();
                          },
                          title: 'IMITATION',
                          width: 100,
                          height: 40,
                          textcolor:
                              c.buttonIndex == 4
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                          bgColor:
                              c.buttonIndex == 4
                                  ? AppColors.buttonFFAE00Color
                                  : AppColors.whiteColor.withOpacity(0.4),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        ButtonWidget(
                          onTap: () {
                            c.buttonIndex = 5;
                            c.update();
                          },
                          title: 'HAIR ACC.',
                          width: 100,
                          height: 40,
                          textcolor:
                              c.buttonIndex == 5
                                  ? AppColors.blackColor
                                  : AppColors.whiteColor,
                          bgColor:
                              c.buttonIndex == 5
                                  ? AppColors.buttonFFAE00Color
                                  : AppColors.whiteColor.withOpacity(0.4),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: ApiStateWidget<ManageOrderModel?>(
                    response: c.orderModel,
                    dataBuilder: (data) {
                      return ListView.builder(
                        itemCount: (data?.orders ?? []).length,

                        padding: EdgeInsets.all(15),
                        itemBuilder: (context, index) {
                          final orders = data?.orders?[index];
                          return Container(
                            width: double.infinity,
                            height: 42,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color:
                                  index % 2 != 0
                                      ? AppColors.buttonFFADCBColor.withOpacity(
                                        0.7,
                                      )
                                      : AppColors.buttonFFDEDFColor.withOpacity(
                                        0.7,
                                      ),
                            ),

                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  cText(
                                    value:
                                        orders?.date == null
                                            ? ""
                                            : DateFormat(
                                              'dd-MM-yyyy',
                                            ).format(orders!.date!),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  AppSpacing.w50,
                                  cText(
                                    value: orders?.city ?? "",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),

                                  AppSpacing.w10,
                                  Container(
                                    width: width * 0.5,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        colors:
                                            index == 0
                                                ? [
                                                  AppColors.buttonAC9017Color,
                                                  AppColors.button4D410AColor
                                                      .withOpacity(0.1),
                                                ]
                                                : index == 1
                                                ? [
                                                  AppColors.button17AC9DColor,
                                                  AppColors.button4D410AColor
                                                      .withOpacity(0.1),
                                                ]
                                                : [
                                                  AppColors.button24AC17Color,
                                                  AppColors.button4D410AColor
                                                      .withOpacity(0.1),
                                                ],
                                      ),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        AppSpacing.w16,
                                        cText(
                                          value: '${orders?.category ?? ""} ',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        cText(
                                          value: 'KAHAI JEWELS',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ),
                                  AppSpacing.w10,
                                  ButtonWidget(
                                    height: 36,
                                    onTap: () {},
                                    title: orders?.status ?? "",
                                    bgColor: AppColors.buttonFFAE00Color,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    textcolor: AppColors.blackColor,
                                    border: Border.all(
                                      color: AppColors.blackColor,
                                    ),
                                  ),
                                  AppSpacing.w10,
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
