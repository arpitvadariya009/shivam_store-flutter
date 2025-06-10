import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/api_state_manage.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/view/orders/controller/orders_controller.dart';
import 'package:shivam_stores/view/orders/model/order_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      builder: (c) {
        return ApiStateWidget<OrderModel?>(
          response: c.orderModel,
          dataBuilder: (data) {
            return ListView.builder(
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
                      RichText(
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
