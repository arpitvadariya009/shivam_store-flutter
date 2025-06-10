import 'package:flutter/material.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';

class LoaderService {
  static LoaderService? _instance;
  static LoaderService get instance => _instance ??= LoaderService._();

  LoaderService._();

  bool _isShowing = false;
  BuildContext? _context;

  // Show loader dialog
  void show(BuildContext context, {String? message}) {
    if (_isShowing) return;

    _isShowing = true;
    _context = context;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.blackColor.withOpacity(0.5),

      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            title: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.blackColor),
              ),
            ),
          ),
        );
      },
    );
  }

  // Hide loader dialog
  void hide() {
    if (!_isShowing || _context == null) return;

    Navigator.of(_context!).pop();
    _isShowing = false;
    _context = null;
  }

  // Check if loader is currently showing
  bool get isShowing => _isShowing;
}
