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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent, // ✅ Important
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: cText(
          value: Strings.kWelcomeBack,
          fontSize: 20,
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),

      body: GetBuilder<AuthController>(
        builder: (c) {
          return Center(
            child: Form(
              key: c.loginFormKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),

                children: [
                  Row(
                    spacing: 15,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleText(value: Strings.kMobileNumber),
                            textFormField(
                              controller: c.mobileTXTController,
                              validator: Validators.validateMobile,
                              hintText: Strings.kEnteryour10digitnumber,
                              keyboardType: TextInputType.phone,
                              prefixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppSpacing.w10,
                                  Text(
                                    '+91',
                                    style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleText(value: Strings.kPIN),
                            pinTextField(
                              length: 4,
                              appContext: context,
                              controller: c.pinTXTController,
                              validator:
                                  (value) =>
                                      Validators.validate(value, Strings.kPIN),
                            ),
                            cText(
                              value: Strings.kResetPIN,
                              color: AppColors.whiteColor,
                              fontSize: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  AppSpacing.h16,

                  Align(
                    alignment: Alignment.centerLeft,
                    child: ButtonWidget(
                      width: width * 0.3,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.tealColor,
                          AppColors.blackShadeColor,
                        ],
                      ),
                      onTap: () async {
                        await c.login(context: context);
                      },
                      title: Strings.kLogin,
                    ),
                  ),

                  AppSpacing.h16,

                  Align(
                    alignment: Alignment.centerLeft,
                    child: ButtonWidget(
                      width: width * 0.2,
                      bgColor: AppColors.darkPurpuleColor,
                      onTap: () async {
                        Get.offNamed(AppRoutes.kRegisterScreen);
                      },
                      title: Strings.kRegister,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
