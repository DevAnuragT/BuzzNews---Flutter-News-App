import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Config/ApiKeys.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'SettingsController.dart'; // Import the SettingsController

class FeedController extends GetxController {
  final String category;
  FeedController({required this.category});

  final SettingsController settingsController = Get.put(SettingsController()); // Find the existing SettingsController

  RxList<NewsModel> feedList = <NewsModel>[].obs;
  RxString nextPage = ''.obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews(category);
  }

  Future<void> refreshNews() async {
    currentIndex.value = 0;
    nextPage.value = '';
    feedList.clear();
    fetchNews(category);
  }

  Future<void> fetchNews(String category) async {
    String url;
    String language = settingsController.selectedLanguage.value.substring(0,2).toLowerCase(); // Get the selected language
    String temp = settingsController.selectedCountry.value; // Get the selected country
    String country= temp=='India'? 'in': 'us';

    if (category.isNotEmpty) {
      if (nextPage.isEmpty) {
        url = 'https://newsdata.io/api/1/latest?apikey=$newsKey&size=10&language=$language&category=$category';
      } else {
        url = 'https://newsdata.io/api/1/latest?apikey=$newsKey&size=10&language=$language&category=$category&page=$nextPage';
      }
    } else {
      if (nextPage.isEmpty) {
        url = 'https://newsdata.io/api/1/latest?apikey=$newsKey&size=10&language=$language&country=$country';
      } else {
        url = 'https://newsdata.io/api/1/latest?apikey=$newsKey&size=10&language=$language&country=$country&page=$nextPage';
      }
    }

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['results'];
        for (var news in articles) {
          bool isDuplicate = feedList.any((e) => e.title == news['title']);
          if (!isDuplicate) {
            feedList.add(NewsModel.fromJson(news));
          }
        }
        if (body['nextPage'] != null) {
          nextPage.value = body['nextPage'];
        }
      }
    } catch (e) {
      print('Error : $e');
    }
  }
}
