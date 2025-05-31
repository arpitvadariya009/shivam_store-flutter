import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/Strings.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/validators.dart';
import 'package:shivam_stores/core/widget/button_widget.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_form_field.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/view/auth/controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        elevation: 0,
        title: cText(
          value: Strings.kLoginNow,
          fontSize: 20,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),

      body: GetBuilder<AuthController>(
        builder: (c) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              titleText(value: Strings.kFirmName),
              textFormField(
                controller: c.firmNameTXTController,
                hintText: Strings.kEnter + Strings.kFirmName,
                validator:
                    (value) => Validators.validate(value, Strings.kFirmName),
              ),
              AppSpacing.h10,

              titleText(value: Strings.kPassword),
              textFormField(
                controller: c.passwordTXTController,
                validator:
                    (value) => Validators.validate(value, Strings.kPassword),

                hintText: Strings.kEnter + Strings.kPassword,

                suffixIcon: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.kDashboardScreen);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      cText(value: Strings.kSHOW, fontSize: 14),
                      AppSpacing.w10,
                    ],
                  ),
                ),
              ),
              AppSpacing.h5,
              cText(
                value: Strings.kForgetPassword,
                color: AppColors.hintColor,
                fontSize: 10,
              ),
              AppSpacing.h24,
              ButtonWidget(
                onTap: () {
                  Get.toNamed(AppRoutes.kVerificationScreen);
                },
                title: Strings.kLogin,
              ),
              AppSpacing.h16,

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: Strings.kDonthaveanaccountSignUp,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.blackColor,
                      ),
                    ),
                    TextSpan(
                      text: Strings.kSignUp,
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
                            },
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
