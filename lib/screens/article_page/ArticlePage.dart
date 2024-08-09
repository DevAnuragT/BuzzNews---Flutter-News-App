import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/article_page/widgets/GeminiButton.dart';
import 'package:news_app/screens/article_page/widgets/ImageViewer.dart';
import 'package:news_app/screens/article_page/widgets/VideoPlayer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Controller/GeminiController.dart';
import '../../Model/NewsModel.dart';

// ignore: must_be_immutable
class ArticlePage extends StatelessWidget {
  final NewsModel news;
  RxBool showBack = false.obs;
  final PageController pageController = PageController();
  GeminiController gemini = GeminiController();

  ArticlePage({required this.news, required this.showBack});

  // Function to launch URL
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }

  // Function to handle horizontal swipe
  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity != null) {
      if (details.primaryVelocity! < 0) {
        print('Swiped Left');
        _launchURL(news.url!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: showBack.value
          ? FloatingActionButton(
              onPressed: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 30,
              ),
            )
          : null,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: PageView(
        controller: pageController,
        children: [
          _buildArticlePage(context),
        ],
      ),
    );
  }

  Widget _buildArticlePage(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(ImageViewer(imageUrl: news.imageUrl));
                  },
                  child: Container(
                    height: 270,
                    width: double.infinity,
                    child: news.videoUrl != null && news.videoUrl!.isNotEmpty
                        ? VideoPlayerWidget(videoUrl: news.videoUrl!)
                        : news.imageUrl != null &&
                                news.imageUrl!.isNotEmpty &&
                                news.imageUrl !=
                                    'https://via.placeholder.com/150'
                            ? Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(news.imageUrl!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10, sigmaY: 10),
                                      child: Container(
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Image.network(
                                      news.imageUrl!,
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                      height: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Center(
                                        child: Image.asset(
                                          'assets/Photos/default_news.png',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Image.asset(
                                'assets/Photos/default_news.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                  ),
                ),
              ),
              if (news.category != null && news.category!.isNotEmpty)
                Positioned(
                  top: 40,
                  right: 5,
                  child: Container(
                    child: Text(
                      news.category!.capitalize!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              // if (showBack.value)
              //   Positioned(
              //     top: 40, // Adjust the position according to your needs
              //     left: 16,
              //     child: InkWell(
              //       onTap: () {
              //         Get.back();
              //       },
              //       child: Container(
              //         padding: const EdgeInsets.all(8),
              //         decoration: const BoxDecoration(
              //           color: Colors.black45,
              //           shape: BoxShape.circle,
              //         ),
              //         child: const Icon(
              //           Icons.arrow_back_ios_new_rounded,
              //           color: Colors.white,
              //           size: 24,
              //         ),
              //       ),
              //     ),
              //   ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 3, 5, 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    'BuzzNews',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontFamily: 'SFRounded',
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          letterSpacing: 1.5,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.title!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GeminiButton(
                      title: news.title!,
                    ),
                    if (news.time != 'No Data')
                      Text(news.time,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 14))
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.description!,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 15),
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        if (news.sourceUrl != null &&
                            news.sourceUrl!.isNotEmpty) {
                          _launchURL(news.sourceUrl!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Source URL not available.'),
                            ),
                          );
                        }
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          news.author != 'Unknown Author'
                              ? "${news.author} From ${news.source}"
                              : "${news.source}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: news.sourceIcon != null &&
                                  news.sourceIcon!.isNotEmpty
                              ? NetworkImage(news.sourceIcon!)
                              : const AssetImage('assets/Photos/Profile.png')
                                  as ImageProvider,
                          radius: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Swipe to read full article >',
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
            )
          ]),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
