import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  final String videoUrl;
  late VideoPlayerController videoPlayerController;
  RxBool isInitialized = false.obs;

  VideoController(this.videoUrl);

  @override
  void onInit() {
    super.onInit();
    videoPlayerController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        isInitialized.value = true;
        update();
      });
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    super.onClose();
  }

  void playPause() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
    update();
  }
}
