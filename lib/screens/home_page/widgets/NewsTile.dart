import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsTile extends StatelessWidget {
  final String title;
  final String? author;
  final String time;
  final String? imageUrl;
  final String? source;
  final String? sourceIcon;
  final String? category;
  //final String? url;
  //final String? videoUrl;
  final VoidCallback onTap;

  NewsTile({
    required this.title,
    this.author,
    this.imageUrl,
    required this.time,
    this.source,
    this.sourceIcon,
    this.category,
    // this.url,
    // this.videoUrl
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer,
          boxShadow: [
            Theme.of(context).brightness == Brightness.light
                ? BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3), // Adjusted shadow offset for a more natural look
            )
                : BoxShadow(
              color: Colors.white.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 1), // Adjusted shadow offset for a more natural look
            ),
          ],
        ),
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Hero(
              tag: 'image',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: imageUrl != null && imageUrl != 'https://via.placeholder.com/150'
                    ? Image.network(
                  imageUrl!,
                  fit: BoxFit.fitHeight,
                  width: 125,
                  height: 130,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Image.asset(
                      'assets/Photos/default_news.png',
                      fit: BoxFit.fitHeight,
                      width: 125,
                      height: 130,
                    ),
                  ),
                )
                    : Image.asset(
                  'assets/Photos/default_news.png',
                  fit: BoxFit.fitHeight,
                  width: 120,
                  height: 130,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (category != null)
                        Text(
                          category!.capitalize!,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      Text(
                        time,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 8),
                  // Author and source
                  if (author != null && source != null)
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: sourceIcon != null && sourceIcon!.isNotEmpty
                              ? NetworkImage(sourceIcon!)
                              : AssetImage('assets/Photos/Profile.png') as ImageProvider,
                          radius: 10,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            author != 'Unknown Author'
                                ? "${author} From ${source}"
                                : "${source}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
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
