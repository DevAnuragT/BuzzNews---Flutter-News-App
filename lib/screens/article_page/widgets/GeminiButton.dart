import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package
import 'package:news_app/Controller/GeminiController.dart';
import 'MoreInfo.dart';

class GeminiButton extends StatelessWidget {
  final GeminiController gemini = GeminiController();
  final String title;

  GeminiButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (BuildContext context) {
            return GeminiBottomSheet(
              title: title,
              gemini: gemini,
            );
          },
        );
      },
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(3),
        shadowColor:
        MaterialStateProperty.all(Theme.of(context).colorScheme.onSurface),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, color: Colors.blueAccent),
          const SizedBox(width: 8),
          Text(
            'Describe with',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              fontFamily: 'Roboto', // Custom font if required
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'Gemini',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Gemini Description',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          isLoading
              ? _buildShimmerEffect(context)
              : Text(
            description ?? "No description available.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: (){
              Get.to(() => DetailedDescriptionPage(description: description!));
            },
            child: Text(
              'Know More',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildShimmerEffect(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryContainer,
      highlightColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: List.generate(5, (index) => _buildShimmerLine(context)),
      ),
    );
  }

  Widget _buildShimmerLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        height: 20,
        color: Colors.white,
      ),
    );
  }
}
