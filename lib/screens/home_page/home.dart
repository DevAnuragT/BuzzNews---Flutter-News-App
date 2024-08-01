import 'package:flutter/material.dart';
import 'package:news_app/screens/home_page/widgets/NewsTile.dart';
import 'package:news_app/screens/home_page/widgets/TrendingCard.dart';
import 'package:news_app/Components/NavigationBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Text('Welcome to',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 12, 12),
                      child: Text(
                        'BuzzNews',
                        textAlign: TextAlign.left,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontSize: 50,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top News',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 18),
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
                    child: Row(
                      children: [
                        TrendingCard(
                            title: 'First News',
                            time: '1 min ago',
                            trending: '2',
                            author: "Anurag",
                            source: 'IIITM',
                            image:
                                'https://scx2.b-cdn.net/gfx/news/2024/project-sheds-light-on.jpg'),
                        TrendingCard(
                            title: 'First News',
                            time: '1 min ago',
                            trending: '2',
                            author: "Anurag",
                            source: 'IIITM',
                            image:
                                'https://scx2.b-cdn.net/gfx/news/2024/project-sheds-light-on.jpg'),
                        TrendingCard(
                            title: 'First News',
                            time: '1 min ago',
                            trending: '2',
                            author: "Anurag",
                            source: 'IIITM',
                            image:
                                'https://scx2.b-cdn.net/gfx/news/2024/project-sheds-light-on.jpg'),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'News For you',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text('See All',
                            style: Theme.of(context).textTheme.labelSmall)
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    NewsTile(
                        title: 'title',
                        author: 'author',
                        imageUrl:
                            'https://scx2.b-cdn.net/gfx/news/2024/project-sheds-light-on.jpg',
                        time: '2 days ago',
                        source: 'source'),
                    NewsTile(
                        title: 'title',
                        author: 'author',
                        imageUrl:
                            'https://scx2.b-cdn.net/gfx/news/2024/project-sheds-light-on.jpg',
                        time: '2 days ago',
                        source: 'source'),
                    NewsTile(
                        title: 'title',
                        author: 'author',
                        imageUrl:
                            'https://scx2.b-cdn.net/gfx/news/2024/project-sheds-light-on.jpg',
                        time: '2 days ago',
                        source: 'source'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
