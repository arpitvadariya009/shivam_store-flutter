import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';

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
