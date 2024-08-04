import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../Controller/VideoController.dart';


class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;
  final VideoController controller;

  VideoPlayerWidget({required this.videoUrl})
      : controller = Get.put(VideoController(videoUrl));

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isInitialized.value) {
        return AspectRatio(
          aspectRatio: controller.videoPlayerController.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              VideoPlayer(controller.videoPlayerController),
              VideoProgressIndicator(controller.videoPlayerController, allowScrubbing: true),
              FloatingActionButton(
                onPressed: controller.playPause,
                child: Icon(
                  controller.videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ],
          ),
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }
}
