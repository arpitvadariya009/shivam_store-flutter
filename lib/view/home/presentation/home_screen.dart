import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shivam_stores/core/routes/app_routes.dart';
import 'package:shivam_stores/core/utils/app_colors.dart';
import 'package:shivam_stores/core/utils/strings.dart';

import 'package:shivam_stores/core/widget/api_state_manage.dart';
import 'package:shivam_stores/core/widget/image.dart';
import 'package:shivam_stores/core/widget/spacing.dart';
import 'package:shivam_stores/core/widget/text_widget.dart';
import 'package:shivam_stores/view/home/controller/home_controller.dart';
import 'package:shivam_stores/view/home/model/categories_model.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,

          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: List.generate(Strings.labels.length, (index) {
            return GestureDetector(
              onTap: () {
                final homeController = Get.find<HomeController>();
                homeController.pause();
                if (index == 2) {
                  Get.toNamed(
                    AppRoutes.kShopDetailScreen,
                    arguments: {
                      'id': '684408b7895f91b3d090e07d',
                      'title': "FAVORITE",
                      'bgColor': AppColors.lightYellowColor,
                      'textColor': AppColors.blackColor,
                    },
                  );
                } else if (index == 3) {
                  Get.toNamed(AppRoutes.kCartScreen);
                } else if (index == 1) {
                  Get.toNamed(AppRoutes.kOrdersScreen);
                } else if (index == 0) {
                  Get.toNamed(AppRoutes.kProfileScreen);
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,

                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                decoration: BoxDecoration(
                  gradient: Strings.labels[index]['color'],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: cText(
                  value: Strings.labels[index]['name'],
                  color: AppColors.textPrimaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }),
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (c) {
          return ApiStateWidget<CategoriesModel?>(
            response: c.categoriesModel,
            dataBuilder: (data) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        left: 20,
                        top: 22,
                        bottom: 16,
                        right: 5,
                      ),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: height * 0.35,
                                width: double.infinity,
                                padding: EdgeInsets.all(5),
                                color: AppColors.whiteColor.withOpacity(0.2),

                                child: Column(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: netWorkImage(
                                          imageUrl: catData?.image ?? "",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    Container(
                                      color: AppColors.blackColor,
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      alignment: Alignment.center,
                                      child: cText(
                                        value:
                                            (catData?.name ?? "").toUpperCase(),
                                        fontSize: 16,

                                        fontWeight: FontWeight.w600,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              AppSpacing.h16,
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child:
                        c.controller.value.isInitialized
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppSpacing.h16,
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'WEL-COME TO DIGITAL WORLD OF',
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),

                                      WidgetSpan(child: AppSpacing.w10),
                                      TextSpan(
                                        text: 'S H I V A M',
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.whiteColor.withOpacity(
                                          0.1,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),

                                        child: AspectRatio(
                                          aspectRatio:
                                              c.controller.value.aspectRatio,
                                          child: VideoPlayer(c.controller),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                            : Center(
                              child: CircularProgressIndicator(
                                color: AppColors.blackColor,
                              ),
                            ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
