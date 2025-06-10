import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';

showToast({
  required String message,
  Color backgroundColor = AppColors.black1E1E1EColor,
  Color textColor = AppColors.whiteColor,
  ToastGravity gravity = ToastGravity.BOTTOM,
  Toast toastLength = Toast.LENGTH_LONG,
  int timeInSecForIosWeb = 2,
  double fontSize = 14,
}) async {
  await Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength,
    gravity: gravity,
    timeInSecForIosWeb: timeInSecForIosWeb,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: fontSize,
  );
}
