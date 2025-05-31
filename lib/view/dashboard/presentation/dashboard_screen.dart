import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/view/dashboard/controller/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (c) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
            surfaceTintColor: AppColors.whiteColor,
            leading: Container(),
            backgroundColor: AppColors.whiteColor,
            elevation: 0,
            title:
                c.currentPage == 0
                    ? null
                    : cText(
                      value: Strings.titledashboard[c.currentPage - 1],
                      fontSize: 20,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
            centerTitle: true,
            toolbarHeight: c.currentPage == 0 ? 20 : null,
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(Strings.labels.length, (index) {
                bool isSelected = c.currentPage == index;
                return GestureDetector(
                  onTap: () {
                    c.currentPage = index;
                    c.update();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding:
                        isSelected
                            ? const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            )
                            : const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppColors.selectedButtonBgColor
                              : AppColors.iconBgColor,
                      borderRadius:
                          isSelected
                              ? BorderRadius.circular(30)
                              : BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Strings.svgIcons[index],
                          color:
                              isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.unselectedIconColor,
                        ),
                        if (isSelected)
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: cText(
                              value: Strings.labels[index],
                              color: AppColors.whiteColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          body: c.screens[c.currentPage],
        );
      },
    );
  }
}
