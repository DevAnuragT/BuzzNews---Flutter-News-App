import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  final String title;
  final String? author;
  final String time;
  final String? imageUrl;
  final String? source;
  final String? sourceIcon;

  NewsTile({
    required this.title,
    this.author,
    this.imageUrl,
    required this.time,
    this.source,
    this.sourceIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer,
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
                      0, 1), // Adjusted shadow offset for a more natural look
                ),
        ],
      ),
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          // Display a placeholder image if imageUrl is null
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: imageUrl != null &&
                    imageUrl != 'https://via.placeholder.com/150'
                ? Image.network(imageUrl!,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 100,
                    errorBuilder: (context, error, stackTrace) => Center(
                            child: Image.asset(
                          'assets/Photos/default_news.png',
                          fit: BoxFit.cover,
                          width: 120,
                          height: 100,
                        )))
                : Image.asset(
                    'assets/Photos/default_news.png',
                    fit: BoxFit.cover,
                    width: 120,
                    height: 100,
                  ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display author and source only if both are provided
                if (author != null && source != null)
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                        sourceIcon != null && sourceIcon!.isNotEmpty
                            ? NetworkImage(sourceIcon!)
                            : AssetImage('assets/Photos/Profile.png'),
                        radius: 8,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '$author from $source',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 10),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: 10),
                Text(
                  time,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
