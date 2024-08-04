import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/Controller/NewsController.dart';
import 'package:news_app/screens/article_page/ArticlePage.dart';
import 'package:news_app/screens/home_page/widgets/NewsTile.dart';
import 'package:news_app/screens/home_page/widgets/SearchWidget.dart';
import 'package:news_app/screens/home_page/widgets/TrendingCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());

    return Scaffold(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(Icons.dashboard_rounded),
                        ),
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(Icons.person_2_rounded),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 22),
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
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontFamily: 'SFRounded',
                                  fontWeight: FontWeight.w900,
                                  fontSize: 50,
                                  letterSpacing: 2.0,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ),
                    //SizedBox(height: 5),
                    SearchWidget(),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hottest News',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 20),
                        ),
                        Text(
                          'See more',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(
                      () => Row(
                          children: newsController.trendingNewsList
                              .map(
                                (e) => TrendingCard(
                                  onTap: () {
                                    Get.to(ArticlePage(news: e));
                                  },
                                  title: e.title!,
                                  time: e.time,
                                  trending: '1',
                                  author: e.author!,
                                  source: e.source!,
                                  image: e.imageUrl,
                                  category: e.category,
                                  sourceIcon: e.sourceIcon,
                                  // url: e.url!,
                                  // videoUrl: e.videoUrl,
                                ),
                              )
                              .toList()),
                    ),
                  ),
                ],
              ),
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
                        Text('See All',
                            style: Theme.of(context).textTheme.labelSmall)
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => Column(
                        children: newsController.newsForYouList
                            .map((e) => NewsTile(
                                  onTap: () {
                                    Get.to(ArticlePage(news: e));
                                  },
                                  title: e.title!,
                                  author: e.author,
                                  imageUrl: e.imageUrl,
                                  time: e.time,
                                  source: e.source,
                                  sourceIcon: e.sourceIcon,
                                  // url: e.url,
                                  // videoUrl: e.videoUrl,
                                  category: e.category,
                                ))
                            .toList()))
                  ],
                ),
              ),
              SizedBox(height: 60),
              Text(
                '�� 2024 BuzzNews. All rights reserved.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
