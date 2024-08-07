import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controller/BottomNavigation.dart';

import 'Components/NavigationBar.dart';

class HomePageController extends StatelessWidget {
  const HomePageController({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavController controller=Get.put(BottomNavController());
    return Scaffold(
      body: Stack(
        children: [
          Obx(()=> controller.pages[controller.index.value]),
          const Navigationbar(),
        ],
      ),
    );
  }
}
