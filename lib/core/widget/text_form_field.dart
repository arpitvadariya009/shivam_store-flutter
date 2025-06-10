import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Widget textFormField({
  required TextEditingController controller,
  String? hintText,
  Widget? suffixIcon,
  Widget? prefixIcon,
  TextInputType? keyboardType,
  void Function(String)? onChanged,
  void Function()? onTap,
  String? Function(String?)? validator,
  List<TextInputFormatter>? inputFormatters,
  bool obscureText = false,
}) {
  return TextFormField(
    controller: controller,
    inputFormatters: inputFormatters,
    validator: validator,
    onTap: onTap,
    onChanged: onChanged,
    style: TextStyle(
      color: AppColors.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    obscureText: obscureText,
    keyboardType: keyboardType,
    cursorColor: AppColors.blackColor,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: AppColors.hintColor, fontSize: 12),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      fillColor: AppColors.textFieldBgColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

pinTextField({
  required BuildContext appContext,
  required int length,
  TextEditingController? controller,
  void Function(String)? onCompleted,
  void Function(String)? onChanged,
  String? Function(String?)? validator,
}) {
  return PinCodeTextField(
    appContext: appContext,
    length: length,
    validator: validator,
    obscureText: false,
    mainAxisAlignment: MainAxisAlignment.start,
    cursorColor: AppColors.blackColor,
    keyboardType: TextInputType.number,
    animationType: AnimationType.fade,
    textStyle: TextStyle(
      color: AppColors.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),

    pinTheme: PinTheme(
      fieldOuterPadding: EdgeInsets.only(right: 15),
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(5),
      fieldHeight: 50,
      fieldWidth: 50,
      activeColor: AppColors.transparentColor,
      selectedColor: AppColors.transparentColor,
      inactiveColor: AppColors.transparentColor,
      activeFillColor: AppColors.textFieldBgColor,
      selectedFillColor: AppColors.textFieldBgColor,
      inactiveFillColor: AppColors.textFieldBgColor,
    ),

    animationDuration: Duration(milliseconds: 300),
    enableActiveFill: true,
    controller: controller,
    onCompleted: onCompleted,
    onChanged: onChanged,
    beforeTextPaste: (text) {
      return true;
    },
  );
}
