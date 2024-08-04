import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/article_page/widgets/VideoPlayer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Model/NewsModel.dart';

class ArticlePage extends StatelessWidget {
  final NewsModel news;
  ArticlePage({required this.news});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Container(
                  height: 320,
                  width: double.infinity,
                  child: news.videoUrl != null && news.videoUrl!.isNotEmpty
                      ? VideoPlayerWidget(videoUrl: news.videoUrl!)
                      : news.imageUrl != null &&
                      news.imageUrl!.isNotEmpty &&
                      news.imageUrl != 'https://via.placeholder.com/150'
                      ? Image.network(
                    news.imageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Image.asset(
                        'assets/Photos/default_news.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  )
                      : Image.asset(
                    'assets/Photos/default_news.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              Positioned(
                top: 40, // Adjust the position according to your needs
                left: 16,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
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
                    SizedBox(height: 20),
                    Text(
                      news.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        if (news.sourceUrl != null && news.sourceUrl!.isNotEmpty) {
                          _launchURL(news.sourceUrl!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
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
                              : AssetImage('assets/Photos/Profile.png') as ImageProvider,
                          radius: 15,
                        ),
                        minLeadingWidth: 7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: InkWell(
              onTap: () async {
                if (news.url != null && news.url!.isNotEmpty) {
                  _launchURL(news.url!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('News Article URL not available.'),
                    ),
                  );
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Read Full Article',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
