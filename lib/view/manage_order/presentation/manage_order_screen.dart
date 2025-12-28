import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/api_state_manage.dart';
import 'package:shivam_stores/core/widget/button_widget.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/manage_order/controller/manage_order_controller.dart';
import 'package:shivam_stores/view/manage_order/model/manage_order_model.dart';

class ManageOrderScreen extends StatelessWidget {
  const ManageOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey _button1Key = GlobalKey();
    final GlobalKey _button2Key = GlobalKey();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.button2C0203Color,
      appBar: AppBar(
        surfaceTintColor: AppColors.button2C0203Color,

        leading: Container(),
        leadingWidth: 0,
        toolbarHeight: 20,
        backgroundColor: AppColors.button2C0203Color,
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
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      ButtonWidget(
                        onTap: () {
                          c.buttonIndex = 0;
                          c.value = null;
                          c.status = null;
                          c.fetchOrder(
                            category: c.selectedCategoryName ?? '',
                            status: c.selcetdStatusID ?? '',
                          );
                          c.update();
                        },
                        title: 'All',
                        width: 80,
                        height: 30,
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
                            date: DateTime.now(),
                            category: c.selectedCategoryName ?? '',
                            status: c.selcetdStatusID ?? '',
                          );
                          c.update();
                        },
                        title: 'TODAY',
                        width: 80,
                        height: 30,
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

                      ButtonWidget(
                        onTap: () {
                          c.buttonIndex = 2;
                          c.fetchOrder(
                            date: DateTime.now().subtract(
                              const Duration(days: 1),
                            ),
                            status: c.selcetdStatusID ?? '',
                            category: c.selectedCategoryName ?? '',
                          );

                          c.update();
                        },
                        title: 'YESTERDAY',
                        width: 100,
                        height: 30,
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

                      // ButtonWidget(
                      //   onTap: () {
                      //     c.buttonIndex = 3;
                      //     c.fetchOrder(status: '0');
                      //     c.update();
                      //   },
                      //   title: 'PENDING',
                      //   width: 100,
                      //   height: 40,
                      //   textcolor:
                      //       c.buttonIndex == 3
                      //           ? AppColors.blackColor
                      //           : AppColors.whiteColor,
                      //   bgColor:
                      //       c.buttonIndex == 3
                      //           ? AppColors.buttonFFAE00Color
                      //           : AppColors.whiteColor.withOpacity(0.4),
                      //   fontSize: 12,
                      //   fontWeight: FontWeight.w500,
                      // ),
                      // ButtonWidget(
                      //   onTap: () {
                      //     c.buttonIndex = 4;
                      //     c.fetchOrder(status: '1');
                      //     c.update();
                      //   },
                      //   title: 'IN PROCESS',
                      //   width: 100,
                      //   height: 40,
                      //   textcolor:
                      //       c.buttonIndex == 4
                      //           ? AppColors.blackColor
                      //           : AppColors.whiteColor,
                      //   bgColor:
                      //       c.buttonIndex == 4
                      //           ? AppColors.buttonFFAE00Color
                      //           : AppColors.whiteColor.withOpacity(0.4),
                      //   fontSize: 12,
                      //   fontWeight: FontWeight.w500,
                      // ),
                      // ButtonWidget(
                      //   onTap: () {
                      //     c.buttonIndex = 5;
                      //     c.fetchOrder(status: '2');
                      //     c.update();
                      //   },
                      //   title: 'DONE',
                      //   width: 100,
                      //   height: 40,
                      //   textcolor:
                      //       c.buttonIndex == 5
                      //           ? AppColors.blackColor
                      //           : AppColors.whiteColor,
                      //   bgColor:
                      //       c.buttonIndex == 5
                      //           ? AppColors.buttonFFAE00Color
                      //           : AppColors.whiteColor.withOpacity(0.4),
                      //   fontSize: 12,
                      //   fontWeight: FontWeight.w500,
                      // ),
                      AppSpacing.w32,

                      Spacer(),

                      AppSpacing.w32,

                      ButtonWidget(
                        key: _button2Key, // Assign the GlobalKey

                        onTap: () async {
                          final RenderBox renderBox =
                              _button2Key.currentContext?.findRenderObject()
                                  as RenderBox;
                          final Offset position = renderBox.localToGlobal(
                            Offset.zero,
                          );
                          final Size size = renderBox.size;

                          // Calculate the RelativeRect based on the button's position and size
                          final RelativeRect buttonRect = RelativeRect.fromLTRB(
                            position.dx,
                            position.dy +
                                size.height, // Position the top of the menu just below the button
                            position.dx + size.width,
                            position.dy +
                                size.height +
                                100, // Bottom edge (arbitrary value to define height constraint)
                          );

                          await showMenu(
                            context: context,
                            position: buttonRect,
                            color: Colors.white,
                            items: [
                              for (int i = 0; i < Strings.statuss.length; i++)
                                PopupMenuItem(
                                  value: i,

                                  onTap: () {
                                    c.status = Strings.statuss[i]['status'];
                                    c.selcetdStatusID =
                                        Strings.statuss[i]['id'] ?? '';
                                    c.fetchOrder(
                                      status: Strings.statuss[i]['id'] ?? '',
                                      category: c.selectedCategoryName ?? '',

                                      date:
                                          c.buttonIndex == 1
                                              ? DateTime.now()
                                              : c.buttonIndex == 2
                                              ? DateTime.now().subtract(
                                                const Duration(days: 1),
                                              )
                                              : null,
                                    );
                                    c.update();
                                  },
                                  child: Text(
                                    Strings.statuss[i]['status'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                        title: c.status ?? "Status",
                        width: 100,
                        height: 30,
                        textcolor:
                            // c.buttonIndex == 3
                            //     ? AppColors.blackColor
                            //     :
                            AppColors.whiteColor,
                        bgColor:
                        // c.buttonIndex == 3
                        //     ? AppColors.buttonFFAE00Color
                        //     :
                        AppColors.whiteColor.withOpacity(0.4),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),

                      ButtonWidget(
                        key: _button1Key, // Assign the GlobalKey

                        onTap: () async {
                          final RenderBox renderBox =
                              _button1Key.currentContext?.findRenderObject()
                                  as RenderBox;
                          final Offset position = renderBox.localToGlobal(
                            Offset.zero,
                          );
                          final Size size = renderBox.size;

                          // Calculate the RelativeRect based on the button's position and size
                          final RelativeRect buttonRect = RelativeRect.fromLTRB(
                            position.dx,
                            position.dy +
                                size.height, // Position the top of the menu just below the button
                            position.dx + size.width,
                            position.dy +
                                size.height +
                                100, // Bottom edge (arbitrary value to define height constraint)
                          );

                          await showMenu(
                            context: context,
                            position: buttonRect,
                            color: Colors.white,
                            items: [
                              PopupMenuItem(
                                value: 'All',

                                onTap: () {
                                  c.value = 'All';

                                  c.selectedCategoryName = null;

                                  c.fetchOrder(
                                    category: '',
                                    status: c.selcetdStatusID ?? '',
                                    date:
                                        c.buttonIndex == 1
                                            ? DateTime.now()
                                            : c.buttonIndex == 2
                                            ? DateTime.now().subtract(
                                              const Duration(days: 1),
                                            )
                                            : null,
                                  );
                                  c.update();
                                },
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              for (int i = 0; i < c.categoryName.length; i++)
                                PopupMenuItem(
                                  value: i,

                                  onTap: () {
                                    c.value = c.categoryName[i];

                                    c.selectedCategoryName = c.categoryName[i];

                                    c.fetchOrder(
                                      category: c.categoryName[i],
                                      status: c.selcetdStatusID ?? '',
                                      date:
                                          c.buttonIndex == 1
                                              ? DateTime.now()
                                              : c.buttonIndex == 2
                                              ? DateTime.now().subtract(
                                                const Duration(days: 1),
                                              )
                                              : null,
                                    );
                                    c.update();
                                  },
                                  child: Text(
                                    c.categoryName[i],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                        title: c.value ?? "Category",
                        width: 100,
                        height: 30,
                        textcolor:
                            // c.buttonIndex == 3
                            //     ? AppColors.blackColor
                            //     :
                            AppColors.whiteColor,
                        bgColor:
                        // c.buttonIndex == 3
                        //     ? AppColors.buttonFFAE00Color
                        //     :
                        AppColors.whiteColor.withOpacity(0.4),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      AppSpacing.w32,
                    ],
                  ),
                ),

                Expanded(
                  child: ApiStateWidget<ManageOrderModel?>(
                    response: c.orderModel,
                    dataBuilder: (data) {
                      return (data?.orders ?? []).isEmpty
                          ? Center(
                            child: cText(
                              value: 'No data available',
                              color: AppColors.whiteColor,
                            ),
                          )
                          : ListView.builder(
                            itemCount: (data?.orders ?? []).length,
                            padding: EdgeInsets.all(15),
                            itemBuilder: (context, index) {
                              final orders = data?.orders?[index];
                              return GestureDetector(
                                onTap: () {
                                  log(
                                    "---------orders?.note--->${orders?.note}",
                                  );
                                  Get.toNamed(
                                    AppRoutes.kCartScreen,
                                    arguments: {
                                      'orderId': orders?.orderId,
                                      'api_name':
                                          "${ApiEndpoints.getToOrder}${orders?.orderId ?? ''}&userId=${HiveService().getValue(HiveService.userId)}",
                                      'status': orders?.status ?? "",
                                      'name': orders?.firmName,
                                      'note': orders?.note,
                                    },
                                  );

                                  c.fetchOrder(
                                    category: c.selectedCategoryName ?? '',
                                    status: c.selcetdStatusID ?? '',
                                    date:
                                        c.buttonIndex == 1
                                            ? DateTime.now()
                                            : c.buttonIndex == 2
                                            ? DateTime.now().subtract(
                                              const Duration(days: 1),
                                            )
                                            : null,
                                  );
                                  c.update();
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 35,
                                  margin: EdgeInsets.only(bottom: 5),
                                  padding: EdgeInsets.only(left: 15),
                                  decoration: BoxDecoration(
                                    color:
                                        orders?.colorCode == null
                                            ? index % 2 != 0
                                                ? AppColors.buttonFFADCBColor
                                                    .withOpacity(0.7)
                                                : AppColors.buttonFFDEDFColor
                                                    .withOpacity(0.7)
                                            : Strings.hexToColor(
                                              orders?.colorCode ?? '#FFDEDF',
                                            ),
                                  ),

                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      cText(
                                        value: orders?.date ?? '',
                                        // orders?.date == null
                                        //     ? ""
                                        //     : DateFormat(
                                        //       'dd-MM-yyyy',
                                        //     ).format(orders!.date!),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),

                                      AppSpacing.w10,
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        spacing: 5,
                                        children: [
                                          cText(
                                            value: orders?.city ?? "",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            textAlign: TextAlign.start,
                                          ),
                                          // cText(
                                          //   value: '${orders?.category ?? ""} ',
                                          //   fontSize: 20,
                                          //   fontWeight: FontWeight.w600,
                                          // ),
                                          cText(
                                            value: orders?.firmName ?? "",
                                            fontSize: 20,
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.2,
                                      ),

                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ButtonWidget(
                                            // height: 36,
                                            alignment: Alignment.centerRight,
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return GetBuilder<
                                                    ManageOrderController
                                                  >(
                                                    builder: (cc) {
                                                      return Dialog(
                                                        backgroundColor:
                                                            AppColors
                                                                .blackColor,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                vertical: 20,
                                                                horizontal: 40,
                                                              ),
                                                          child: Column(
                                                            verticalDirection:
                                                                VerticalDirection
                                                                    .down,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              cText(
                                                                value:
                                                                    Strings
                                                                        .kStatusUpdate,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    AppColors
                                                                        .whiteColor,
                                                              ),
                                                              AppSpacing.h16,
                                                              for (
                                                                int i = 0;
                                                                i <
                                                                    Strings
                                                                        .status
                                                                        .length;
                                                                i++
                                                              ) ...[
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20,
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
                                                                                Strings.status[i]['id']
                                                                            ? AppColors.buttonFFAE00Color
                                                                            : AppColors.whiteColor.withOpacity(
                                                                              0.4,
                                                                            ),

                                                                    borderRadius:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    textcolor:
                                                                        cc.statusID ==
                                                                                Strings.status[i]['id']
                                                                            ? AppColors.blackColor
                                                                            : AppColors.whiteColor,
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
                                                                        orders
                                                                            ?.orderId ??
                                                                        "",
                                                                    status:
                                                                        c.statusID ??
                                                                        "",
                                                                    context:
                                                                        context,
                                                                    category:
                                                                        c.selectedCategoryName,
                                                                    statusFilter:
                                                                        c.status,

                                                                    date:
                                                                        c.buttonIndex ==
                                                                                1
                                                                            ? DateTime.now()
                                                                            : c.buttonIndex ==
                                                                                2
                                                                            ? DateTime.now().subtract(
                                                                              const Duration(
                                                                                days:
                                                                                    1,
                                                                              ),
                                                                            )
                                                                            : null,
                                                                  );
                                                                },
                                                                title:
                                                                    Strings
                                                                        .kUpdate,
                                                                gradient: LinearGradient(
                                                                  begin:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  end:
                                                                      Alignment
                                                                          .centerRight,
                                                                  colors: [
                                                                    AppColors
                                                                        .buttonFF65F0Color
                                                                        .withOpacity(
                                                                          0.7,
                                                                        ),
                                                                    AppColors
                                                                        .darkBlueColor,
                                                                  ],
                                                                ).withOpacity(
                                                                  0.9,
                                                                ),
                                                                borderRadius:
                                                                    50,
                                                                textcolor:
                                                                    AppColors
                                                                        .whiteColor,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              );

                                              // c.updateOrderStatus(
                                              //   orderId: orders?.orderId ?? "",
                                              //   status: status,
                                              //   context: context,
                                              // );
                                            },

                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.15,
                                            title: orders?.status ?? "",
                                            bgColor: AppColors.whiteColor
                                                .withOpacity(0.4),
                                            fontSize: 18,
                                            borderRadius: 0,
                                            fontWeight: FontWeight.w600,
                                            textcolor: AppColors.lightGreyColor,
                                            border: null,
                                          ),

                                          Container(
                                            // height: 36,
                                            width: 40,

                                            decoration: BoxDecoration(
                                              gradient:
                                                  orders?.status
                                                              ?.toLowerCase() ==
                                                          Strings.kInProcess
                                                              .toLowerCase()
                                                      ? LinearGradient(
                                                        colors: [
                                                          AppColors
                                                              .inprogress1Color,
                                                          AppColors
                                                              .inprogress2Color,
                                                        ],
                                                        begin:
                                                            Alignment
                                                                .centerLeft,
                                                        end:
                                                            Alignment
                                                                .centerRight,
                                                      )
                                                      : orders?.status
                                                              ?.toLowerCase() ==
                                                          Strings.kPending
                                                              .toLowerCase()
                                                      ? LinearGradient(
                                                        colors: [
                                                          AppColors
                                                              .penddingColor
                                                              .withOpacity(0.5),
                                                          AppColors
                                                              .penddingColor,
                                                        ],
                                                        begin:
                                                            Alignment
                                                                .centerLeft,
                                                        end:
                                                            Alignment
                                                                .centerRight,
                                                      )
                                                      : LinearGradient(
                                                        colors: [
                                                          AppColors.redColor
                                                              .withOpacity(0.5),
                                                          AppColors.redColor,
                                                        ],
                                                        begin:
                                                            Alignment
                                                                .centerLeft,
                                                        end:
                                                            Alignment
                                                                .centerRight,
                                                      ),
                                            ),
                                            // color:
                                            //     orders?.status?.toLowerCase() ==
                                            //             Strings.kInProcess
                                            //                 .toLowerCase()
                                            //         ? AppColors.button24AC17Color
                                            //         : orders?.status
                                            //                 ?.toLowerCase() ==
                                            //             Strings.kPending
                                            //                 .toLowerCase()
                                            //         ? AppColors.blue0800FFCColor
                                            //         : AppColors.redColor,
                                          ),
                                        ],
                                      ),
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
