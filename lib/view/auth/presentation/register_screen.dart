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

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: Container(),
        surfaceTintColor: AppColors.whiteColor,

        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: cText(
          value: Strings.kRegisterNow,
          fontSize: 20,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),

      body: GetBuilder<AuthController>(
        builder: (c) {
          return Form(
            key: c.registerFormKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleText(value: Strings.kFirmName),
                          textFormField(
                            controller: c.firmNameTXTController,
                            hintText: Strings.kEnter + Strings.kFirmName,
                            validator:
                                (value) => Validators.validate(
                                  value,
                                  Strings.kFirmName,
                                ),
                          ),

                          AppSpacing.h10,

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
                    AppSpacing.w24,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          titleText(value: Strings.kCity),
                          textFormField(
                            controller: c.cityTXTController,
                            hintText: Strings.kEnter + Strings.kCity,
                            validator:
                                (value) =>
                                    Validators.validate(value, Strings.kCity),
                          ),
                          AppSpacing.h10,

                          titleText(value: Strings.kPIN),
                          pinTextField(
                            length: 4,
                            appContext: context,
                            controller: c.pinTXTController,
                            validator:
                                (value) =>
                                    Validators.validate(value, Strings.kPIN),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                AppSpacing.h24,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      splashRadius: 0,
                      activeColor: AppColors.blackColor,
                      value: c.isPivacyValid,
                      onChanged: (val) {
                        c.isPivacyValid = val ?? false;
                        c.update();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Flexible(
                      child: cText(
                        value: Strings.kIAgreewithTermPrivcy,
                        color: AppColors.blackColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                AppSpacing.h16,
                Center(
                  child: ButtonWidget(
                    width: 200,
                    onTap: () async {
                      c.clean();
                      await c.register(context: context);
                    },
                    title: Strings.kRegister,
                  ),
                ),
                AppSpacing.h16,

                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: Strings.kAlreadyhaveanaccount,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.blackColor,
                        ),
                      ),
                      TextSpan(
                        text: Strings.kSignIn,
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.kLoginScreen);
                                Get.find<AuthController>().clean();
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
