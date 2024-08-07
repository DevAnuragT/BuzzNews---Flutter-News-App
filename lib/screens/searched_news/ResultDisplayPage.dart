import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/SearchController.dart';
import '../article_page/ArticlePage.dart';
import '../home_page/widgets/NewsTile.dart';
import '../home_page/widgets/NewsTileLoading.dart';

class ResultPage extends StatelessWidget {
  final String query;
  ResultPage({required this.query});

  @override
  Widget build(BuildContext context) {
    final SearchingController searchController = Get.put(SearchingController());

    // Trigger the search when the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchController.searchNews(query);
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Search Results for: $query', style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: Obx(() {
        if (searchController.isSearchLoading.value) {
          return ListView.builder(
            itemCount: 8, // Number of shimmer tiles
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
              child: NewsTileShimmer(),
            ),
          );
        } else if (searchController.searchedNewsList.isEmpty) {
          return Center(child: Text('No results found', style: Theme.of(context).textTheme.bodyMedium));
        } else {
          return ListView.builder(
            itemCount: searchController.searchedNewsList.length+1,
            itemBuilder: (context, index) {
              if (index == searchController.searchedNewsList.length) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: ElevatedButton(
                    onPressed: () {
                      searchController.searchNews(query);
                    },
                    child: Text('Show More',),
                  ),
                );
              } else{
                var e = searchController.searchedNewsList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add horizontal padding
                  child: NewsTile(
                    onTap: () {
                      Get.to(() => ArticlePage(news: e, showBack: true.obs),transition: Transition.rightToLeft);
                    },
                    title: e.title!,
                    author: e.author,
                    imageUrl: e.imageUrl,
                    time: e.time,
                    source: e.source,
                    sourceIcon: e.sourceIcon,
                    category: e.category,
                  ),
                );
              }
            },
          );
        }
      }),
    );
  }
}
