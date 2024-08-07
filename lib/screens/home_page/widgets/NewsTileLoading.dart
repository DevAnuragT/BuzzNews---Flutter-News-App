import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsTileShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryContainer,
      highlightColor: Theme.of(context).colorScheme.surface,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 80,
              color: Colors.grey[300],
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 15,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    height: 15,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 100,
                    height: 15,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
