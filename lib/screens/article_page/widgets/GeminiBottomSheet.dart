import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            Colors.deepPurple.shade100
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Gemini Description',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            isLoading
                ? _buildShimmerEffect(context)
                : Stack(
              children: [
                // Text with border (stroke)
                Text(
                  description ?? "No description available.",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth =  1
                      ..color = Colors.black38, // Border color
                  ),
                ),
                // Text with fill color
                Text(
                  description ?? "No description available.",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white, // Fill color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            isLoading?
             SizedBox()
            :TextButton(
              onPressed: () {
                Get.to(() => DetailedDescriptionPage(description: description!));
              },
              child: const Text(
                'Know More',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerEffect(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.white70,
      child: Column(
        children: List.generate(6, (index) => _buildShimmerLine(context)),
      ),
    );
  }

  Widget _buildShimmerLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
        width: double.infinity,
        height: 20,
      ),
    );
  }
}
