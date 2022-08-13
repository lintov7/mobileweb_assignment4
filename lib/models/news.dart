
class News {
  final String? abstract;
  final List<String>? multimedia;
  final String? publishedDate;
  final String? title;
  final String? url;

  const News({
    this.abstract,
    this.multimedia,
    this.publishedDate,
    this.title,
    this.url,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      abstract: json['abstract'].toString(),
      multimedia: (json['multimedia'] as List<dynamic>?)?.map((i) => i['url'].toString()).toList(),
      publishedDate: json['published_date'],
      title: json['title'],
      url: json['url'],
    );
  }
}