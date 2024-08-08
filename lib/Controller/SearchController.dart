import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Config/ApiKeys.dart';
import '../Model/NewsModel.dart';

class SearchingController extends GetxController {
  RxBool isSearchLoading = false.obs;
  RxString nextPage=''.obs;
  RxList<NewsModel> searchedNewsList = <NewsModel>[].obs;
  String language = 'en';

  Future<void> searchNews(String query) async {
    String baseURL;
    isSearchLoading.value = true;
    if (query.contains(' ')) {
      if (nextPage.isEmpty) {
        baseURL =
        "https://newsdata.io/api/1/latest?apiKey=$newsKey&qInTitle='$query'&size=10&language=$language";
        searchedNewsList.clear();
      }
      else
        baseURL= "https://newsdata.io/api/1/latest?apiKey=$newsKey&qInTitle='$query'&size=10&language=$language&page=$nextPage";
    }
    else {
      if (nextPage.isEmpty) {
        baseURL =
        "https://newsdata.io/api/1/latest?apiKey=$newsKey&qInTitle=$query&size=10&language=$language";
        searchedNewsList.clear();
      }
      else
        baseURL = "https://newsdata.io/api/1/latest?apiKey=$newsKey&qInTitle=$query&size=10&language=$language&page=$nextPage";
    }
    try {
      var response = await http.get(Uri.parse(baseURL));
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['results'];
        for (var news in articles) {
          bool isDuplicate = searchedNewsList.any((e) => e.title == news['title']);
          if (!isDuplicate) {
            searchedNewsList.add(NewsModel.fromJson(news));
          }
        }
        nextPage.value = body['nextPage'];
      } else {
        print("Something went wrong in Search News: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isSearchLoading.value = false;
    }
  }
}
