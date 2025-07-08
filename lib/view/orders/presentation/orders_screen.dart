import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/api_state_manage.dart';
import 'package:shivam_stores/core/widget/button_widget.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/orders/controller/orders_controller.dart';
import 'package:shivam_stores/view/orders/model/order_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      init: OrdersController(),
      builder: (c) {
        return ApiStateWidget<OrderModel?>(
          response: c.orderModel,
          dataBuilder: (data) {
            return (data?.data ?? []).isEmpty
                ? Center(child: cText(value: 'No data available'))
                : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  itemCount: data?.data?.length,
                  itemBuilder: (context, index) {
                    final order = data?.data?[index];
                    return Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: AppColors.textFieldBgColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: cText(
                                  value: 'Shiva Selection',
                                  color: AppColors.blackColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              AppSpacing.w10,

                              Flexible(
                                child: cText(
                                  value: DateFormat(
                                    'dd-MM-yyyy',
                                  ).format(order?.date ?? DateTime.now()),
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w600,

                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          AppSpacing.h16,
                          Align(
                            alignment: Alignment.topLeft,

                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                children: [
                                  for (
                                    int i = 0;
                                    i < (order?.products ?? []).length;
                                    i++
                                  )
                                    TextSpan(
                                      text: '${order?.products?[i]}       ',

                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                          if (HiveService().getValue(HiveService.isStaff) ==
                              true) ...[
                            AppSpacing.h16,
                            Align(
                              alignment: Alignment.centerRight,
                              child: ButtonWidget(
                                onTap: () {
                                  c.statusID = order?.status.toString();
                                  c.update();
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return GetBuilder<OrdersController>(
                                        builder: (cc) {
                                          return Dialog(
                                            backgroundColor:
                                                AppColors.whiteColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 40,
                                                  ),
                                              child: Column(
                                                verticalDirection:
                                                    VerticalDirection.down,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  cText(
                                                    value:
                                                        Strings.kStatusUpdate,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.blackColor,
                                                  ),
                                                  AppSpacing.h16,
                                                  for (
                                                    int i = 0;
                                                    i < Strings.status.length;
                                                    i++
                                                  ) ...[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                          ),
                                                      child: ButtonWidget(
                                                        onTap: () {
                                                          cc.statusID =
                                                              Strings
                                                                  .status[i]['id'];
                                                          cc.update();
                                                        },
                                                        height: 35,

                                                        title:
                                                            Strings
                                                                .status[i]['status'],
                                                        bgColor:
                                                            cc.statusID ==
                                                                    Strings
                                                                        .status[i]['id']
                                                                ? AppColors
                                                                    .blackColor
                                                                : AppColors
                                                                    .whiteColor,
                                                        borderRadius: 0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        textcolor:
                                                            cc.statusID ==
                                                                    Strings
                                                                        .status[i]['id']
                                                                ? AppColors
                                                                    .whiteColor
                                                                : AppColors
                                                                    .blackColor,
                                                        border: Border.all(
                                                          color:
                                                              AppColors
                                                                  .blackColor,
                                                        ),
                                                      ),
                                                    ),
                                                    AppSpacing.h10,
                                                  ],
                                                  AppSpacing.h16,
                                                  ButtonWidget(
                                                    onTap: () {
                                                      c.updateOrderStatus(
                                                        orderId:
                                                            order?.id ?? "",
                                                        status:
                                                            c.statusID ?? "",
                                                        context: context,
                                                      );
                                                    },
                                                    title: Strings.kUpdate,
                                                    bgColor:
                                                        AppColors.greenColor,
                                                    borderRadius: 5,
                                                    textcolor:
                                                        AppColors.blackColor,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                height: 30,
                                width: 150,
                                bgColor:
                                    (order?.status ?? "").toString() == '1'
                                        ? AppColors.black505050Color
                                        : (order?.status ?? "").toString() ==
                                            '2'
                                        ? AppColors.greenColor
                                        : AppColors.frizYellowColor,
                                textcolor:
                                    (order?.status ?? "").toString() != '2'
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
                                title:
                                    order?.status.toString() == '0'
                                        ? Strings.kDone
                                        : (Strings.status.firstWhere(
                                              (e) =>
                                                  e['id'] ==
                                                  (order?.status ?? "")
                                                      .toString(),
                                              orElse: () => {'status': ''},
                                            )['status'] ??
                                            ''),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                );
          },
        );
      },
    );
  }
}
