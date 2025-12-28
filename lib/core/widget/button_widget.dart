import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Color? bgColor;
  final Color? textcolor;
  final double? height;
  final double? fontSize;
  final double? borderRadius;
  final double? width;
  final FontWeight? fontWeight;
  final BoxBorder? border;
  final Widget? leadingWidget;
  final Widget? tralingWidget;
  final Gradient? gradient;
  final DecorationImage? image;
  final MainAxisAlignment? mainAxisAlignment;
  final void Function(TapDownDetails)? onTapDown;

  final AlignmentGeometry? alignment;
  final int? maxLines;

  final TextAlign? textAlign;

  const ButtonWidget({
    Key? key,
    this.onTap,
    required this.title,
    this.bgColor,
    this.textcolor,
    this.height,
    this.borderRadius,
    this.fontSize,
    this.width,
    this.fontWeight,
    this.border,
    this.leadingWidget,
    this.tralingWidget,
    this.gradient,
    this.image,
    this.mainAxisAlignment,
    this.onTapDown,
    this.alignment,
    this.maxLines,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onTapDown: onTapDown,
      child: Container(
        height: height ?? 50,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: alignment ?? Alignment.center,
        decoration: BoxDecoration(
          image: image,
          border: border,
          color: bgColor,

          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        child:
            leadingWidget != null || tralingWidget != null
                ? Row(
                  mainAxisAlignment:
                      mainAxisAlignment ?? MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    leadingWidget ?? Container(),
                    AppSpacing.w10,
                    Flexible(
                      child: cText(
                        value: title,
                        maxLines: maxLines,

                        textAlign: textAlign ?? TextAlign.center,
                        fontSize: fontSize ?? 16,
                        color: textcolor ?? AppColors.whiteColor,
                        fontWeight: fontWeight ?? FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    tralingWidget ?? Container(),
                  ],
                )
                : cText(
                  value: title,
                  maxLines: maxLines,

                  textAlign: textAlign ?? TextAlign.center,
                  fontSize: fontSize ?? 16,
                  color: textcolor ?? AppColors.whiteColor,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
      ),
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData? icon;
  final String? image;
  final Color? bgColor;
  final Color? iconColor;
  final double? size;
  final double? iconSize;
  final double? borderRadius;

  const IconButtonWidget({
    Key? key,
    required this.onTap,
    this.icon,
    this.image,
    this.bgColor,
    this.iconColor,
    this.size,
    this.iconSize,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size ?? 50,
        width: size ?? 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.blackColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
        ),
        child:
            image != null
                ? Image.asset(
                  image!,
                  height: iconSize ?? 20,
                  width: iconSize ?? 20,
                )
                : Icon(icon, color: iconColor ?? AppColors.whiteColor),
      ),
    );
  }
}
