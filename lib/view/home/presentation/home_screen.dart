import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: cText(
            value: Strings.kWelcometoShivamStores,
            color: AppColors.textPrimaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        AppSpacing.h10,
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            physics: ClampingScrollPhysics(),
            itemCount: Strings.homeData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,

              crossAxisSpacing: 10,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),

                        child: Image.asset(
                          Strings.homeData[index]['image'],

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  AppSpacing.h5,
                  cText(
                    value: Strings.homeData[index]['name'],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
