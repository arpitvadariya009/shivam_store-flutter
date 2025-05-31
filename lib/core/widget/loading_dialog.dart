import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';

class LoadingDialog {
  // Show loading dialog
  static void show({String? message}) {
    if (!(Get.isDialogOpen ?? false)) {
      Get.dialog(
        WillPopScope(
          onWillPop: () async => false, // Prevent dismiss on back button
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: AppColors.whiteColor),
                if (message != null) ...[
                  SizedBox(height: 15),
                  Text(message, style: TextStyle(color: AppColors.whiteColor)),
                ],
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  // Hide loading dialog
  static void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
