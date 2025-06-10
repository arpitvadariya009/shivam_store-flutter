import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/services/api_endpoints.dart';

Widget netWorkImage({required String imageUrl, BoxFit? fit}) {
  return CachedNetworkImage(
    imageUrl: ApiEndpoints.imageUrl + imageUrl,
    fit: fit ?? BoxFit.cover,
    progressIndicatorBuilder:
        (context, url, downloadProgress) => Center(
          child: CircularProgressIndicator(
            value: downloadProgress.progress,
            color: AppColors.blackColor,
          ),
        ),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
