import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:news_app/Controller/GeminiController.dart';
import 'GeminiLoading.dart';

class DetailedDescriptionPage extends StatefulWidget {
  final String description;

  DetailedDescriptionPage({required this.description, Key? key})
      : super(key: key);

  @override
  State<DetailedDescriptionPage> createState() =>
      _DetailedDescriptionPageState();
}

class _DetailedDescriptionPageState extends State<DetailedDescriptionPage> {
  RxBool isLoading = false.obs;
  RxString moreInfo = ''.obs;
  final GeminiController gemini = GeminiController();

  @override
  void initState() {
    super.initState();
    _loadMoreInfo();
  }

  Future<void> _loadMoreInfo() async {
    try {
      isLoading.value = true;
      moreInfo.value = await gemini.getMoreInfo(widget.description);
    } catch (e) {
      print('Failed to load more info: $e');
      moreInfo.value = 'Failed to load more info';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.3),
        leading: Row(
          children: [
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.close,
                  color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(width: 20),
            const Icon(
              Icons.auto_awesome,
              color: Colors.blueAccent,
              size: 32,
            ),
          ],
        ),
        leadingWidth: 90,
        title: Text(
          'Gemini Description',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 21),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent.shade100,
              Colors.lightBlueAccent.shade100,
              Colors.deepPurple.shade200
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(
            () => Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white70.withOpacity(0.4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: isLoading.value
                    ? GeminiLoading(20)
                    : MarkdownBody(
                        data: moreInfo.value,
                        styleSheet: MarkdownStyleSheet(
                          p: TextStyle(color: Colors.black),
                          h2: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                          strong: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
