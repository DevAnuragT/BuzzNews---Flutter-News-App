import 'package:flutter/material.dart';
import 'package:news_app/Config/Colors.dart';

class TrendingCard extends StatelessWidget {
  final String title;
  final String time;
  final String trending;
  final String author;
  final String source;
  final String image;

  TrendingCard({
    required this.title,
    required this.time,
    required this.trending,
    required this.author,
    required this.source,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
            height: 150,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trending #$trending",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      '$time',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: 8),
                ListTile(
                  title: Text(
                    "$author From $source",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/Photos/Profile.png'),
                    radius: 12,
                  ),
                  minLeadingWidth: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
