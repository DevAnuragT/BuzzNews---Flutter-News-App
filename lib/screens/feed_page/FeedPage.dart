import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controller/FeedController.dart';
import 'package:news_app/Model/NewsModel.dart';
import 'package:news_app/screens/article_page/ArticlePage.dart';
import 'package:news_app/screens/article_page/loading/ArticleLoading.dart';

class FeedPage extends StatefulWidget {
  final String category;
  FeedPage({required this.category});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late FeedController _feedController;

  @override
  void initState() {
    super.initState();
    _feedController = Get.put(FeedController(category: widget.category));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _feedController.refreshNews,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Obx(() {
          if (_feedController.feedList.isEmpty) {
            return const ArticleLoading();
          }
          //remove all elements till current index
          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _feedController.feedList.length,
            controller: PageController(initialPage: _feedController.currentIndex.value),
            onPageChanged: (index) {
              _feedController.currentIndex.value = index;
              if (index == _feedController.feedList.length - 1) {
                _feedController.fetchNews(widget.category);
              }
            },
            itemBuilder: (context, index) {
              if(index == _feedController.feedList.length){
                return const ArticleLoading();
              }
              NewsModel news = _feedController.feedList[index];
              return ArticlePage(news: news, showBack: false.obs);
            },
          );
        }),
      ),
    );
  }
}
