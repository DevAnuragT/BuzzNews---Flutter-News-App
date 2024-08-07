import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrendingCard extends StatelessWidget {
  final String title;
  // final String time;
  final String author;
  final String source;
  final String? image;
  final String? category;
  final String? sourceIcon;
  final VoidCallback onTap;

  TrendingCard(
      {required this.title,
      // required this.time,
      required this.author,
      required this.source,
      this.image,
      required this.category,
      required this.sourceIcon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 280,
        margin: EdgeInsets.fromLTRB(8, 0, 3, 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            Theme.of(context).brightness == Brightness.light
                ? BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(
                        0, 3), // Adjusted shadow offset for a more natural look
                  )
                : BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(
                        -1, -2), // Adjusted shadow offset for a more natural look
                  ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'image',
                  child: Container(
                    margin: EdgeInsets.fromLTRB(3, 3, 3, 0),
                    height: 170,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: image != null &&
                              image != 'https://via.placeholder.com/150'
                          ? Image.network(
                              image!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) => Center(
                                  child: Image.asset(
                                      'assets/Photos/breaking_news.png',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Center(
                                              child: Icon(Icons
                                                  .error)))), // Display error icon if the network image fails
                            )
                          : Image.asset(
                              'assets/Photos/breaking_news.png',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) => const Center(
                                  child: Icon(Icons
                                      .error)), // Display error icon if the asset image fails
                            ),
                    ),
                  ),
                ),
                if (category != null && category!.isNotEmpty)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category!.capitalize!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     // Text(
                  //     //   "Trending #$trending",
                  //     //   style: Theme.of(context).textTheme.labelSmall,
                  //     // ),
                  //     Text(
                  //       time,
                  //       style: Theme.of(context).textTheme.labelSmall,
                  //     ),
                  //   ],
                  // ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      author != 'Unknown Author'
                          ? "${author} From ${source}"
                          : "${source}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    leading: CircleAvatar(
                      backgroundImage:
                          sourceIcon != null && sourceIcon!.isNotEmpty
                              ? NetworkImage(sourceIcon!)
                              : AssetImage('assets/Photos/Profile.png'),
                      radius: 13,
                    ),
                    minLeadingWidth: 5,
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
