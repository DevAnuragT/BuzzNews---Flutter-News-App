import 'package:get/get.dart';
import 'package:news_app/screens/article_page/ArticlePage.dart';
import 'package:news_app/screens/home_page/home.dart';
import 'package:news_app/screens/profile_page/ProfilePage.dart';

class BottomNavController extends GetxController{
  RxInt index=0.obs;
  var pages=[
    HomePage(),
    ArticlePage(),
    ProfilePage()
  ];
}