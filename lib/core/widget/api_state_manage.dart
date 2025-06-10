// 5. Generic API State Widget (same as before, no changes needed)
import 'package:flutter/material.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/model/api_response_model.dart';

class ApiStateWidget<T> extends StatelessWidget {
  final ApiResponse<T> response;
  final Widget Function(T data) dataBuilder;
  final Widget? loadingWidget;
  final Widget Function(String error)? errorBuilder;
  final VoidCallback? onRetry;

  const ApiStateWidget({
    Key? key,
    required this.response,
    required this.dataBuilder,
    this.loadingWidget,
    this.errorBuilder,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (response.isLoading) {
      return loadingWidget ??
          const Center(
            child: CircularProgressIndicator(color: AppColors.blackColor),
          );
    }

    if (response.error != null) {
      return errorBuilder?.call(response.error!) ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.redColor,
                ),
                const SizedBox(height: 16),
                cText(
                  value: response.error!,
                  textAlign: TextAlign.center,
                  color: AppColors.redColor,
                ),

                if (onRetry != null) ...[
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: onRetry,
                    child: cText(value: 'Retry'),
                  ),
                ],
              ],
            ),
          );
    }

    if (response.data != null) {
      return dataBuilder(response.data as T);
    }

    return Center(child: cText(value: 'No data available'));
  }
}
