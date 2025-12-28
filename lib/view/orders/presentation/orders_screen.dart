import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        surfaceTintColor: AppColors.powderPurpleColor,
        leading: Container(),
        leadingWidth: 0,
        toolbarHeight: 20,
        backgroundColor: AppColors.powderPurpleColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: cText(
                  value: 'ORDER',
                  fontSize: 16,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.clip,
                ),
              ),
              Flexible(
                child: cText(
                  value: 'S H I V A M',
                  fontSize: 16,
                  color: AppColors.blackColor,

                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.black4E004FColor, AppColors.blackColor],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GetBuilder<OrdersController>(
          init: OrdersController(),
          builder: (c) {
            return ApiStateWidget<OrderModel?>(
              response: c.orderModel,
              dataBuilder: (data) {
                return (data?.groupedOrders ?? {}).isEmpty
                    ? Center(
                      child: cText(
                        value: 'No data available',
                        color: AppColors.whiteColor,
                      ),
                    )
                    : MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 16,
                      ),
                      itemCount: data?.groupedOrders?.length ?? 0,
                      itemBuilder: (context, index) {
                        final date = data!.groupedOrders?.keys.elementAt(index);
                        final order = data.groupedOrders?[date] ?? [];
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: AppColors.transparentColor,
                            border: Border.all(
                              color: AppColors.stokE692FFColor.withOpacity(0.5),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: double.infinity,
                                color: AppColors.blackColor.withOpacity(0.5),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: cText(
                                  value: (date ?? '').isEmpty ? '' : '${date}',
                                  // : DateFormat(
                                  //   'dd-MM-yyyy',
                                  // ).format(DateTime.parse(date ?? "")),
                                  color: AppColors.whiteColor.withOpacity(0.75),
                                  fontWeight: FontWeight.w600,

                                  fontSize: 16,
                                ),
                              ),
                              AppSpacing.h5,
                              for (var order in order)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: cText(
                                    value: "(${order})",

                                    decoration: TextDecoration.underline,

                                    color: AppColors.whiteColor,
                                    decorationColor: AppColors.whiteColor,
                                    fontSize: 14,
                                  ),
                                ),
                              AppSpacing.h10,
                            ],
                          ),
                        );
                      },
                    );
              },
            );
          },
        ),
      ),
    );
  }
}
