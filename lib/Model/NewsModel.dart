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
  });

  NewsModel.fromJson(dynamic json) {
    source = json['source_name'] ?? 'Unknown Source';
    author = json['creator'] != null && json['creator'].isNotEmpty ? json['creator'][0] : 'Unknown Author';
    title = json['title'] ?? 'No Title';
    description = json['description'] ?? 'No Description';
    url = json['link'];
    imageUrl = json['image_url'] ?? 'https://via.placeholder.com/150';
    publishDate = json['pubDate'] ?? 'No Date';
    category = json['category'] != null && json['category'].isNotEmpty ? json['category'][0] : 'No Category';
    sourceIcon = json['source_icon'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['source'] = source;
    map['author'] = author;
    map['title'] = title;
    map['description'] = description;
    map['url'] = url;
    map['image_url'] = imageUrl;
    map['publish_date'] = publishDate;
    map['category'] = category;
    map['source_icon'] = sourceIcon;
    return map;
  }
}
