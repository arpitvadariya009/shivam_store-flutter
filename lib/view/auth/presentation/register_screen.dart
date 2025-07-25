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
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent, // ✅ Important
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),

      body: GetBuilder<AuthController>(
        builder: (c) {
          return Center(
            child: Form(
              key: c.registerFormKey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
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
                          ],
                        ),
                      ),

                      AppSpacing.w24,

                      Flexible(
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
                          ],
                        ),
                      ),
                      AppSpacing.w24,
                      Expanded(
                        flex: 2,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.h24,

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
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
                      AppSpacing.w24,

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleText(value: Strings.kUserName),
                            textFormField(
                              controller: c.usetNameTXTController,
                              hintText: Strings.kEnter + Strings.kUserName,
                              validator:
                                  (value) => Validators.validate(
                                    value,
                                    Strings.kUserName,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      AppSpacing.w24,

                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ButtonWidget(
                            width: width * 0.2,
                            bgColor: AppColors.darkPurpuleColor,
                            onTap: () async {
                              c.register(context: context);
                            },
                            title: Strings.kRegister,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
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
