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
          return Stack(
            children: [
              /// Background Image
              Positioned(
                bottom: Get.height * 0.1,
                left: 0,
                // right: 0,
                child: Image.asset(
                  "assets/image/welcome.png",

                  height: Get.height * 0.28,

                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Form(
                  key: c.loginFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      /// MOBILE + PIN + LOGIN (Row)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// Mobile
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,

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
                                      const SizedBox(width: 10),
                                      const Text(
                                        '+91',
                                        style: TextStyle(
                                          color: Colors.black,
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

                          SizedBox(width: 16),

                          /// PIN
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titleText(value: Strings.kPIN),
                                pinTextField(
                                  length: 4,
                                  appContext: context,
                                  controller: c.pinTXTController,
                                  validator:
                                      (value) => Validators.validate(
                                        value,
                                        Strings.kPIN,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                cText(
                                  value: Strings.kResetPIN,
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 16),

                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                titleText(value: ''),

                                ButtonWidget(
                                  height: 50,
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
                              ],
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      /// NEW USER BUTTON
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ButtonWidget(
                          width: MediaQuery.of(context).size.width * 0.28,
                          bgColor: AppColors.darkPurpuleColor,
                          onTap: () {
                            Get.offNamed(AppRoutes.kRegisterScreen);
                          },
                          title: Strings.kNewUser,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
