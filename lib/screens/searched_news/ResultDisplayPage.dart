import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controller/GeminiController.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../Controller/SearchController.dart';
import '../article_page/ArticlePage.dart';
import '../article_page/widgets/GeminiLoading.dart';
import '../home_page/widgets/NewsTile.dart';
import '../home_page/widgets/NewsTileLoading.dart';

class ResultPage extends StatelessWidget {
  final String query;
  ResultPage({required this.query});

  @override
  Widget build(BuildContext context) {
    final SearchingController searchController = Get.put(SearchingController());
    final GeminiController gemini = Get.put(GeminiController());

    // Trigger the search when the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchController.searchNews(query);
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Search Results for: $query',
            style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: Obx(() {
        if (searchController.isSearchLoading.value) {
          return Column(
            children: [
              const GeminiLoadingContainer(),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: NewsTileShimmer(),
                  ),
                ),
              ),
            ],
          );
        } else if (searchController.searchedNewsList.isEmpty) {
          return Center(
            child: Text(
              'No results found',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        } else {
          return FutureBuilder<String>(
            future: gemini.getSearchResult(searchController.searchedNewsList),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    const GeminiLoadingContainer(),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: NewsTileShimmer(),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blueAccent.shade100,
                              Colors.lightBlueAccent.shade100,
                              Colors.deepPurple.shade200,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(children: [
                          Text(
                            'Gemini Search',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white70.withOpacity(0.4),
                            ),
                            padding: EdgeInsets.all(15),
                            child: MarkdownBody(
                              data: snapshot.data!,
                              styleSheet: MarkdownStyleSheet(
                                h2: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
                                p: TextStyle(color: Colors.black),
                                strong:
                                    const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: searchController.searchedNewsList.length + 1,
                        itemBuilder: (context, index) {
                          if (index ==
                              searchController.searchedNewsList.length) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  searchController.searchNews(query);
                                },
                                child: Text('Show More'),
                              ),
                            );
                          } else {
                            var e = searchController.searchedNewsList[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: NewsTile(
                                onTap: () {
                                  Get.to(
                                    () => ArticlePage(
                                        news: e, showBack: true.obs),
                                    transition: Transition.rightToLeft,
                                  );
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
                      ),
                    ],
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

class GeminiLoadingContainer extends StatelessWidget {
  const GeminiLoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueAccent.shade100,
            Colors.lightBlueAccent.shade100,
            Colors.deepPurple.shade200,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        SizedBox(
          height: 15,
        ),
        Text(
          'Gemini Search',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(
          height: 10,
        ),
        GeminiLoading(8)
      ]),
    );
  }
}
