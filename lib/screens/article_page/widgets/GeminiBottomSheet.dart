import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/screens/article_page/widgets/GeminiLoading.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Controller/GeminiController.dart';
import 'MoreInfo.dart';

class GeminiBottomSheet extends StatefulWidget {
  final String title;
  final GeminiController gemini;

  const GeminiBottomSheet({required this.title, required this.gemini});

  @override
  _GeminiBottomSheetState createState() => _GeminiBottomSheetState();
}

class _GeminiBottomSheetState extends State<GeminiBottomSheet> {
  String? description;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDescription();
  }

  Future<void> _loadDescription() async {
    try {
      String desc = await widget.gemini.getDescription(widget.title);
      setState(() {
        description = desc;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching description: $e");
      setState(() {
        description = "Failed to load description.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Gemini Description',
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 21),
            ),
          ),
          const SizedBox(height: 8),
          isLoading
              ? GeminiLoading(6)
              : Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70.withOpacity(0.4),
                  ),
                  child: Text(
                    description ?? "No description available.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
          const SizedBox(height: 8),
          isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.white70,
            child: Container(
              height: 10,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
            ),
                )
              : TextButton(
                  onPressed: () {
                    Get.to(() =>
                        DetailedDescriptionPage(description: description!));
                  },
                  child: const Text(
                    'Know More',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
