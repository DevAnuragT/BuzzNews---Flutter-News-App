import 'package:flutter/material.dart';
import 'package:news_app/Controller/GeminiController.dart';
import 'GeminiBottomSheet.dart';

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
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, color: Colors.blueAccent),
          SizedBox(width: 8),
          Text(
            'Describe with',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              fontFamily: 'Roboto', // Custom font if required
              color: Colors.black54,
            ),
          ),
          SizedBox(width: 4),
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
