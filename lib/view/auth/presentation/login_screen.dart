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
          return Form(
            key: c.loginFormKey,
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2,
                vertical: 16,
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ButtonWidget(
                          onTap: () {
                            c.isStaff = !c.isStaff;
                            c.update();
                          },
                          title: Strings.kStaff,
                          bgColor:
                              c.isStaff
                                  ? AppColors.greenColor
                                  : AppColors.whiteColor,
                          border: Border.all(color: AppColors.blackColor),
                          borderRadius: 0,
                          fontSize: 14,
                          height: 40,
                          textcolor: AppColors.blackColor,
                          leadingWidget: Image.asset('assets/image/staff.png'),
                        ),
                      ),
                      AppSpacing.w10,
                      Flexible(
                        child: ButtonWidget(
                          onTap: () {
                            c.isStaff = !c.isStaff;
                            c.update();
                          },
                          title: Strings.kCustomer,
                          bgColor:
                              !c.isStaff
                                  ? AppColors.greenColor
                                  : AppColors.whiteColor,
                          border: Border.all(color: AppColors.blackColor),
                          borderRadius: 0,
                          fontSize: 14,
                          height: 40,
                          textcolor: AppColors.blackColor,
                          leadingWidget: Image.asset(
                            'assets/image/customer.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.h24,
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
                AppSpacing.h10,

                titleText(value: Strings.kPIN),
                pinTextField(
                  length: 4,
                  appContext: context,
                  controller: c.pinTXTController,
                  validator:
                      (value) => Validators.validate(value, Strings.kPIN),
                ),
                AppSpacing.h5,
                cText(
                  value: Strings.kResetPIN,
                  color: AppColors.hintColor,
                  fontSize: 10,
                ),
                AppSpacing.h24,
                ButtonWidget(
                  onTap: () async {
                    await c.login(context: context);
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
                                c.clean();
                                Get.offNamed(AppRoutes.kRegisterScreen);
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
            ),
          );
        },
      ),
    );
  }
}
