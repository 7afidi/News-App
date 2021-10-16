import 'package:equatable/equatable.dart';

class NewsModel extends Equatable {
  final String? author;
  final String? title;
  final String? description;
  final String imageUrl;
  final String? content;

  const NewsModel(
      {this.author,
      this.title,
      this.description,
      required this.imageUrl,
      this.content});

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
        author: map["author"] ?? "no author",
        title: map["title"],
        description: map["description"],
        content: map["content"],
        imageUrl: map["urlToImage"] ??
            "https://cdn.futura-sciences.com/buildsv6/images/wide1920/3/6/0/36006517b2_50166642_mz.jpg");
  }
  @override
  List<Object?> get props => [author, title, description, imageUrl, content];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}
