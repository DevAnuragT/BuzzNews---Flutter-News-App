import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controller/NewsController.dart';
import 'package:news_app/screens/home_page/GeminiHighlight.dart';

class AnimatedHighlightWidget extends StatefulWidget {
  final NewsController newsController;

  AnimatedHighlightWidget({required this.newsController});

  @override
  _AnimatedHighlightWidgetState createState() => _AnimatedHighlightWidgetState();
}

class _AnimatedHighlightWidgetState extends State<AnimatedHighlightWidget> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    // Automatically change the widget after 4 seconds
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _showButton = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(child: child, scale: animation);
        },
        child: _showButton
            ? Container(
          key: ValueKey('button'),
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
                offset: Offset(1, 3),
              )
                  : BoxShadow(
                color: Colors.blueAccent.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(1, 3),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              Get.to(()=> GeminiHighlight(newsController: widget.newsController));
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Colors.blueAccent,
                  size: 30,
                ),
                SizedBox(width: 10),
                Text(
                  'Get highlights with',
                  style: TextStyle(color: Colors.black54),
                ),
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
        )
            : Icon(
          Icons.auto_awesome,
          key: ValueKey('icon'),
          color: Colors.blueAccent,
          size: 30,
        ),
      ),
    );
  }
}
