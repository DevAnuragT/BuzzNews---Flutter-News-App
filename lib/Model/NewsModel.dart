import 'package:html/parser.dart' show parseFragment;

class NewsModel {
  String? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? imageUrl;
  String? publishDate;
  String? category;
  String? sourceIcon;
  String? sourceUrl;
  String? videoUrl;
  String time="No Data";

  NewsModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.imageUrl,
    this.publishDate,
    this.category,
    this.sourceIcon,
    this.sourceUrl,
    this.videoUrl,
  });

  String formatTime(String dateTimeString) {
    if (dateTimeString == 'No Data') return 'No Date';
    DateTime now = DateTime.now();
    DateTime inputTime = DateTime.parse(dateTimeString);

    Duration difference = now.difference(inputTime);
    if (difference.inDays == 0) {
      if (difference.inHours > 12) {
        return 'Today';
      } else {
        return '${difference.inHours}hr ago';
      }
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  NewsModel.fromJson(dynamic json) {
    source = json['source_name'] ?? 'Unknown Source';
    author = json['creator'] != null && json['creator'].isNotEmpty ? json['creator'][0] : 'Unknown Author';
    title = json['title'] != null ? parseFragment(json['title']).text : 'No Title';
    description = json['description'] != null ? parseFragment(json['description']).text : 'No Description';
    url = json['link'];
    imageUrl = json['image_url'] ?? 'https://via.placeholder.com/150';
    publishDate = json['pubDate'] ?? 'No Date';
    time=formatTime(publishDate!);
    category = json['category'] != null && json['category'].isNotEmpty ? json['category'][0] : 'No Category';
    sourceIcon = json['source_icon'] ?? null;
    sourceUrl = json['source_url'] ?? null;
    videoUrl = json['video_url'] ?? null;
  }

  Map<String, dynamic> toJson() {

    final map = <String, dynamic>{};
    map['source'] = source;
    map['author'] = author;
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    map['image_url'] = imageUrl;
    map['publish_date'] = time;
    map['category'] = category;
    map['source_icon'] = sourceIcon;
    map['source_url'] = sourceUrl;
    map['video_url'] = videoUrl;
    return map;
  }
}
