// To parse this JSON data, do
//
//     final newsResModel = newsResModelFromJson(jsonString);

import 'dart:convert';

NewsResModel newsResModelFromJson(String str) =>
    NewsResModel.fromJson(json.decode(str));

String newsResModelToJson(NewsResModel data) => json.encode(data.toJson());

class NewsResModel {
  String? status;
  int? totalResults;
  List<Article>? articles;

  NewsResModel({this.status, this.totalResults, this.articles});

  factory NewsResModel.fromJson(Map<String, dynamic> json) => NewsResModel(
    status: json["status"],
    totalResults: json["totalResults"],
    articles:
        json["articles"] == null
            ? []
            : List<Article>.from(
              json["articles"]!.map((x) => Article.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles":
        articles == null
            ? []
            : List<dynamic>.from(articles!.map((x) => x.toJson())),
  };
}

class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: json["source"] == null ? null : Source.fromJson(json["source"]),
    author: json["author"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"],
    publishedAt:
        json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "source": source?.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt?.toIso8601String(),
    "content": content,
  };
}

class Source {
  dynamic id;
  String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) =>
      Source(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
