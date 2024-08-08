import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Config/ApiKeys.dart';
import 'package:news_app/Config/Theme.dart';
import 'package:news_app/HomePageController.dart';
import 'package:flutter_gemini/flutter_gemini.dart';


void main() {
  Gemini.init(apiKey: geminiKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'QuickNews',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode:ThemeMode.system,
      home: HomePageController(),
    );
  }
}

