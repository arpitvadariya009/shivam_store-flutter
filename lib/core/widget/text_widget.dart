import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';

Widget cText({
  required String value,
  int? maxLines,
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
  TextOverflow? overflow,
  TextAlign? textAlign,
  double maxFontSize = double.infinity,
  double minFontSize = 8,
}) {
  return AutoSizeText(
    value,
    maxLines: maxLines,
    textAlign: textAlign,
    maxFontSize: maxFontSize,
    minFontSize: minFontSize,
    overflow: overflow,

    style: TextStyle(
      fontSize: fontSize,
      color: color ?? AppColors.blackColor,
      fontWeight: fontWeight,
      overflow: overflow,
    ),
  );
}

Widget titleText({required String value}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: cText(
      value: value,
      fontSize: 14,
      color: AppColors.blackColor,
      fontWeight: FontWeight.w500,
    ),
  );
}
