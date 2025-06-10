import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/loader_service.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/utils/toast_utils.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/auth/model/user_model.dart';

class AuthController extends GetxController {
  TextEditingController firmNameTXTController = TextEditingController();
  TextEditingController cityTXTController = TextEditingController();
  TextEditingController mobileTXTController = TextEditingController();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController pinTXTController = TextEditingController();
  bool isPasswordValid = false;
  bool isPivacyValid = false;
  final ApiService _apiService = ApiService.instance;
  ApiResponse<UserModel?> userModel = ApiResponse<UserModel?>();

  Future<void> register({required BuildContext context}) async {
    if (registerFormKey.currentState!.validate()) {
      if (isPivacyValid) {
        LoaderService.instance.show(context);

        final response = await _apiService.post<UserModel>(
          ApiEndpoints.register,
          data: jsonEncode({
            "firmName": firmNameTXTController.text,
            "city": cityTXTController.text,
            "mobile": mobileTXTController.text,
            "pin": pinTXTController.text,
          }),
          parser: (data) => UserModel.fromJson(data),
        );
        userModel = response;
        LoaderService.instance.hide();
        update();
        if (userModel.error != null) {
          await showToast(message: userModel.error ?? "");
        } else if (userModel.data != null) {
          await showToast(message: userModel.data?.message ?? "");
          if (userModel.data?.success == true) {
            clean();
            Get.toNamed(AppRoutes.kLoginScreen);
          }
        }
      } else {
        await showToast(
          message: Strings.kPleaseacceptthePrivacyPolicytocontinue,
        );
      }
    }
  }

  Future<void> login({required BuildContext context}) async {
    if (loginFormKey.currentState!.validate()) {
      LoaderService.instance.show(context);

      final response = await _apiService.post<UserModel>(
        ApiEndpoints.login,
        data: jsonEncode({
          "mobile": mobileTXTController.text,
          "pin": pinTXTController.text,
        }),
        parser: (data) => UserModel.fromJson(data),
      );
      userModel = response;
      LoaderService.instance.hide();
      update();
      if (userModel.error != null) {
        await showToast(message: userModel.error ?? "");
      } else if (userModel.data != null) {
        await showToast(message: userModel.data?.message ?? "");
        if (userModel.data?.success == true) {
          await HiveService().setValue(
            HiveService.userId,
            userModel.data?.data?.id,
          );
          clean();
          if (userModel.data?.data?.isverified == true) {
            Get.offNamed(AppRoutes.kDashboardScreen);
          } else {
            Get.toNamed(AppRoutes.kVerificationScreen);
          }
        }
      }
    }
  }

  clean() {
    firmNameTXTController.text = "";
    mobileTXTController.text = "";
    cityTXTController.text = "";
    pinTXTController.text = "";
    isPasswordValid = false;
    isPivacyValid = false;
  }

  @override
  void onClose() {
    firmNameTXTController.clear();
    cityTXTController.clear();
    mobileTXTController.clear();
    pinTXTController.clear();
    isPasswordValid = false;
    isPivacyValid = false;
    super.onClose();
  }
}

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthController());
    // Get.lazyPut(() => AuthController(), fenix: true);
  }
}
