import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Config/ApiKeys.dart';
import 'package:news_app/Controller/SettingsController.dart';
import 'package:news_app/Model/NewsModel.dart';

class NewsController extends GetxController {
  RxBool isTrendLoading = false.obs;
  RxBool isExploreLoading = false.obs;
  RxBool isSearchLoading = false.obs;
  RxList<NewsModel> trendingNewsList = <NewsModel>[].obs;
  RxList<NewsModel> newsForYouList = <NewsModel>[].obs;
  SettingsController settingsController=Get.put(SettingsController());

  @override
  void onInit() {
    super.onInit();
    getTrendingNews();
    getNewsForYou();
  }
  Future<void> refreshNews() async {
    trendingNewsList.clear();
    newsForYouList.clear();
    await getTrendingNews();
    await getNewsForYou();
  }

  Future<void> getTrendingNews() async {
    isTrendLoading.value = true;
    String language = settingsController.selectedLanguage.value.substring(0,2).toLowerCase(); // Get the selected language
    String baseURL = "https://newsdata.io/api/1/latest?apikey=$newsKey&size=10&language=$language";
    try {
      var response = await http.get(Uri.parse(baseURL));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['results'];

        for (var news in articles) {
          bool isDuplicate = trendingNewsList.any((e) =>
          e.title == news['title']) ||
              newsForYouList.any((e) => e.title == news['title']);

          if (!isDuplicate) {
            trendingNewsList.add(NewsModel.fromJson(news));
          }
        }
      } else {
        print("Something went wrong in Trending news");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isTrendLoading.value = false;
    }
  }

  Future<void> getNewsForYou() async {
    isExploreLoading.value = true;
    String language = settingsController.selectedLanguage.value.substring(0,2).toLowerCase(); // Get the selected language
    String temp = settingsController.selectedCountry.value; // Get the selected country
    String country= temp=='India'? 'in': 'us';

    String baseURL = "https://newsdata.io/api/1/news?apikey=$newsKey&size=10&country=$country&language=$language"; // Customize your query as needed
    try {
      var response = await http.get(Uri.parse(baseURL));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['results'];

        for (var news in articles) {
          bool isDuplicate = newsForYouList.any((e) =>
          e.title == news['title']) ||
              trendingNewsList.any((e) => e.title == news['title']);

          if (!isDuplicate) {
            newsForYouList.add(NewsModel.fromJson(news));
          }
        }
      } else {
        print("Something went wrong in News for You");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isExploreLoading.value = false;
    }
  }
}