import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shivam_stores/back_ground_service.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:shivam_stores/view/auth/model/user_model.dart';
import 'package:shivam_stores/view/home/model/categories_model.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  VideoPlayerController? controller;
  final ApiService _apiService = ApiService.instance;
  ApiResponse<CategoriesModel?> categoriesModel =
      ApiResponse<CategoriesModel?>();
  bool isPlaying = false;

  String? videoUrl;
  Timer? _timer;

  @override
  void onInit() async {
    await initLocation(); // 👈 FIX
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    fetchCategories();

    try {
      await _apiService.get<dynamic>(
        ApiEndpoints.teaserVideo,
        parser: (data) => videoUrl = data['data']['url'],
      );

      if (videoUrl != null) {
        controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl!))
          ..initialize().then((value) {
            controller?.play();
            controller?.setLooping(true);
            update();
          });

        controller?.addListener(() {
          update(); // rebuilds GetBuilder when position changes
        });

        // controller!.play();
      }
    } catch (e) {
      log("Video init error : $e");
    }

    super.onInit();
  }

  Future<void> initLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      log("-----------------LocationPermission.denied");

      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      log("--------------------LOCATION PERMISSION DENIED FOREVER");
      return;
    }

    // Permission granted → start timer
    startLocationUpdates();
  }

  void startLocationUpdates() {
    log("-----------------startLocationUpdates");

    Timer.periodic(const Duration(minutes: 1), (timer) async {
      log("-----------------timer------>${timer.tick}");

      await _sendLocationToServer();
    });
  }

  void stopLocationUpdates() {
    _timer?.cancel();
  }

  Future<void> _sendLocationToServer() async {
    log("-----------------_sendLocationToServer");

    try {
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final lat = pos.latitude;
      final lon = pos.longitude;

      log("Sending: LAT: $lat | LON: $lon");

      // 👇 Your API call

      if (HiveService().getValue(HiveService.userId) != null) {
        UserData userData = UserData.fromJson(
          jsonDecode(HiveService().getValue(HiveService.userData)),
        );
        ApiService.instance.put(
          '${ApiEndpoints.updateUser}${HiveService().getValue(HiveService.userId)}',
          data: {
            "firmName": userData.firmName,
            "latitude": lat,
            "longitude": lon,
          },
        );
      }
    } catch (e) {
      print("Location error: $e");
    }
  }

  void togglePlayPause() {
    if (controller?.value.isPlaying ?? false) {
      controller?.pause();
      isPlaying = false;
    } else {
      controller?.play();
      isPlaying = true;
    }

    update();
  }

  void pause() {
    if (controller != null && controller!.value.isInitialized) {
      controller!.pause();
      update();
    }
  }

  void play() {
    if (controller != null && controller!.value.isInitialized) {
      controller!.play();
      update();
    }
  }

  Future<void> fetchCategories() async {
    categoriesModel = ApiResponse<CategoriesModel>().loading();
    update(); // Update UI to show loading

    final response = await _apiService.get<CategoriesModel?>(
      ApiEndpoints.getAllCategories,
      parser: (data) => CategoriesModel.fromJson(data),
    );

    categoriesModel = response;
    List categoryName = [];

    for (int i = 0; i < (categoriesModel.data?.data ?? []).length; i++) {
      categoryName.add(categoriesModel.data?.data?[i].name);
    }
    print("-------------------->categoryName------>${categoryName}");
    HiveService().setValue(HiveService.category, jsonEncode(categoryName));
    update(); // Update UI with data or error
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeController());
  }
}
