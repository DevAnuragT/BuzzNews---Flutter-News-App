import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/NewsController.dart';
import '../article_page/ArticlePage.dart';


class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.put(NewsController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: Text(
                'Feed',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 35, letterSpacing: 2.0),
              ),
            ),
            Expanded(
              child: Obx(
                    () => NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                        newsController.hasMore.value) {
                      newsController.getFeedNews();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: newsController.feedNewsList.length +
                        (newsController.hasMore.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == newsController.feedNewsList.length) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final news = newsController.feedNewsList[index];
                      return ListTile(
                        title: Text(news.title!),
                        subtitle: Text(news.description!),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticlePage(news: news),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
