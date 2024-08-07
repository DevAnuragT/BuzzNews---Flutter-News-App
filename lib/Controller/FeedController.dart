import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/NewsModel.dart';

class FeedController extends GetxController {
  final String category;
  FeedController({required this.category});
  RxList<NewsModel> feedList = <NewsModel>[].obs;
  String apiKey = 'pub_5000780216d8deb17f00cbb6b863c57dc4088';
  RxString nextPage = ''.obs;
  String country = 'in';
  String language = 'en';
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews(category);
  }

  Future<void> refreshNews() async{
    currentIndex.value = 0;
    nextPage.value = '';
    feedList.clear();
    fetchNews(category);
  }

  Future<void> fetchNews(String category) async {
    String url;
    if (category.isNotEmpty) {
      if (nextPage.isEmpty) {
        url = 'https://newsdata.io/api/1/latest?apikey=$apiKey&size=10&language=$language&category=$category';
      } else {
        url = 'https://newsdata.io/api/1/latest?apikey=$apiKey&size=10&language=$language&category=$category&page=$nextPage';
      }
    } else {
      if (nextPage.isEmpty) {
        url = 'https://newsdata.io/api/1/latest?apikey=$apiKey&size=10&language=$language&country=$country';
      } else {
        url = 'https://newsdata.io/api/1/latest?apikey=$apiKey&size=10&language=$language&country=$country&page=$nextPage';
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
