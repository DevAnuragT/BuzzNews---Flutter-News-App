import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controller/NewsController.dart';
import 'package:news_app/screens/article_page/ArticlePage.dart';
import 'package:news_app/screens/feed_page/FeedPage.dart';
import 'package:news_app/screens/home_page/widgets/HighlightAnimation.dart';
import 'package:news_app/screens/home_page/widgets/NewsTile.dart';
import 'package:news_app/screens/home_page/widgets/NewsTileLoading.dart';
import 'package:news_app/screens/home_page/widgets/SearchWidget.dart';
import 'package:news_app/screens/home_page/widgets/TrendingCard.dart';
import 'package:news_app/screens/home_page/widgets/TrendingLoading.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());

    return RefreshIndicator(
      onRefresh: newsController.refreshNews,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      AnimatedHighlightWidget(newsController: newsController),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text('Welcome to,',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                fontFamily: "SFRounded",
                                fontWeight: FontWeight.normal,
                                fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 12, 12),
                        child: Text(
                          'BuzzNews',
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                            fontFamily: 'SFRounded',
                            fontWeight: FontWeight.w900,
                            fontSize: 50,
                            letterSpacing: 2.0,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SearchWidget(),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Latest News',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  if (newsController.isTrendLoading.value) {
                    return Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(3,
                                  (index) => TrendingCardShimmer(),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: newsController.trendingNewsList
                            .map(
                              (e) => TrendingCard(
                            onTap: () {
                              Get.to(
                                      () => ArticlePage(
                                      news: e, showBack: true.obs),
                                  transition: Transition.downToUp);
                            },
                            title: e.title!,
                            author: e.author!,
                            source: e.source!,
                            image: e.imageUrl,
                            category: e.category,
                            sourceIcon: e.sourceIcon,
                          ),
                        )
                            .toList(),
                      ),
                    );
                  }
                }),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Explore',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 20),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(FeedPage(category: ''));
                            },
                            child: Text('See All',
                                style: Theme.of(context).textTheme.labelSmall),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Obx(() {
                        if (newsController.isExploreLoading.value) {
                          return Column(
                            children: List.generate(
                              5,
                                  (index) => NewsTileShimmer(),
                            ),
                          );
                        } else {
                          return Column(
                            children: newsController.newsForYouList
                                .map((e) => NewsTile(
                              onTap: () {
                                Get.to(
                                        () => ArticlePage(
                                        news: e, showBack: true.obs),
                                    transition:
                                    Transition.rightToLeft);
                              },
                              title: e.title!,
                              author: e.author,
                              imageUrl: e.imageUrl,
                              time: e.time,
                              source: e.source,
                              sourceIcon: e.sourceIcon,
                              category: e.category,
                            ))
                                .toList(),
                          );
                        }
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  '© 2024 BuzzNews. All rights reserved.',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
