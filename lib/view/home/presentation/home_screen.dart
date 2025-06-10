import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';
import 'package:shivam_stores/core/widget/api_state_manage.dart';
import 'package:shivam_stores/core/widget/image.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/view/home/controller/home_controller.dart';
import 'package:shivam_stores/view/home/model/categories_model.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) {
        return ApiStateWidget<CategoriesModel?>(
          response: c.categoriesModel,
          dataBuilder: (data) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Flexible(
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: data?.data?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final catData = data?.data?[index];
                        return GestureDetector(
                          onTap: () {
                            c.pause();
                            Get.toNamed(
                              AppRoutes.kShopScreen,
                              arguments: {
                                'title': catData?.name ?? "",
                                'id': catData?.id ?? "",
                              },
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.blackColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: netWorkImage(
                                    imageUrl: catData?.image ?? "",
                                  ),
                                ),
                              ),

                              AppSpacing.h5,
                              cText(
                                value: catData?.name ?? "",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),

                              AppSpacing.h16,
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  AppSpacing.w16,
                  Expanded(
                    child: Center(
                      child:
                          c.controller.value.isInitialized
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),

                                child: AspectRatio(
                                  aspectRatio: c.controller.value.aspectRatio,
                                  child: VideoPlayer(c.controller),
                                ),
                              )
                              : CircularProgressIndicator(
                                color: AppColors.blackColor,
                              ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
