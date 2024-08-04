import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Config/Theme.dart';
import 'package:news_app/HomePageController.dart';

void main() {
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

