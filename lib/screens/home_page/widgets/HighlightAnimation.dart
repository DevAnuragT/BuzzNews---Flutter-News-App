import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controller/NewsController.dart';
import 'package:news_app/screens/home_page/GeminiHighlight.dart';

import '../../../Model/NewsModel.dart';

class AnimatedHighlightWidget extends StatelessWidget {
  final NewsController newsController;
  AnimatedHighlightWidget({required this.newsController});
  @override
  Widget build(BuildContext context) {

    return Center(
      child: GestureDetector(
        onTap: () {
          Get.to(
                () => GeminiHighlight(
              newsController: newsController,
            ),
            transition: Transition.fadeIn,
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.auto_awesome,
                color: Colors.blueAccent,
                size: 30,
              ),
              const SizedBox(width: 10),
              const Text('Get highlights with'),
              const SizedBox(width: 6),
              const Text(
                'Gemini',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
