import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import '../../Controller/NewsController.dart';
import '../../Controller/GeminiController.dart';
import '../../Model/NewsModel.dart';
import '../article_page/widgets/GeminiLoading.dart';

class GeminiHighlight extends StatelessWidget {
  final NewsController newsController;

  GeminiHighlight({required this.newsController});

  @override
  Widget build(BuildContext context) {
    final geminiController = Get.put(GeminiController());

    // Generate highlight content from news lists
    Future<String> generateHighlight() async {
      List<NewsModel> combinedList = [
        ...newsController.trendingNewsList,
        ...newsController.newsForYouList
      ];
      return geminiController.getHighlight(combinedList);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Gemini Highlight', style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Container(
        height: double.infinity,
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
        ),
        child: Obx(() {
          // Check if data is loading
          if (newsController.isTrendLoading.value || newsController.isExploreLoading.value) {
            return Center(child: GeminiLoading(10)); // Show loading indicator while data is being fetched
          } else {
            return FutureBuilder<String>(
                future: generateHighlight(), // Call the method to get highlights
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: GeminiLoading(20)); // Show loading indicator while future is being resolved
                  } else if (snapshot.hasError) {
                    return Center(child: Text('An error occurred: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return Container(
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white70.withOpacity(0.4),
                      ),
                        padding: const EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          child: MarkdownBody(
                            data: snapshot.data ?? "No highlight available",
                            styleSheet: MarkdownStyleSheet(
                              h2: Theme.of(context).textTheme.headlineMedium,
                                p:TextStyle(color: Colors.black87),
                              strong: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                  } else {
                    return Center(child: Text('No data available',style: TextStyle(fontWeight: FontWeight.bold),));
                  }
                },
              );
          }
        }),
      ),
    );
  }
}
