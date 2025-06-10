import 'package:get/get.dart';
import 'package:shivam_stores/model/api_response_model.dart';
import 'package:shivam_stores/services/api_endpoints.dart';
import 'package:shivam_stores/services/api_services.dart';
import 'package:shivam_stores/view/home/model/categories_model.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController {
  late VideoPlayerController controller;
  final ApiService _apiService = ApiService.instance;
  ApiResponse<CategoriesModel?> categoriesModel =
      ApiResponse<CategoriesModel?>();
  @override
  void onInit() {
    fetchCategories();

    controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      ),
    );

    controller
        .initialize()
        .then((_) {
          controller.play();
          update();
        })
        .catchError((error) {
          print('Video initialization failed: $error');
        });
    super.onInit();
  }

  void pause() {
    if (controller.value.isInitialized && controller.value.isPlaying) {
      controller.pause();
    }
  }

  void play() {
    if (controller.value.isInitialized && !controller.value.isPlaying) {
      controller.play();
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
    update(); // Update UI with data or error
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
