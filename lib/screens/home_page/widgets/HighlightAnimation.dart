import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controller/NewsController.dart';
import 'package:news_app/screens/home_page/GeminiHighlight.dart';


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
              Theme.of(context).brightness == Brightness.light
                ? BoxShadow(
              color: Colors.blueAccent.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(
                  1, 3), // Adjusted shadow offset for a more natural look
            )
                : BoxShadow(
              color: Colors.blueAccent.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(
                  1, 3), // Adjusted shadow offset for a more natural look
            ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome,
                color: Colors.blueAccent,
                size: 30,
              ),
              SizedBox(width: 10),
              Text('Get highlights with',style: TextStyle(color: Colors.black54),),
              SizedBox(width: 6),
              Text(
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
