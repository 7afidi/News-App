import 'dart:convert';
import 'dart:convert' as convert; // for jsonDecode
import 'package:news_app/models/news_model.dart';
import 'package:news_app/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/.env.dart';

class NewsRepository extends BaseNewsRepository {
  static const String BASE_URl = "https://newsapi.org/v2/";
  final http.Client _httpClient;

  NewsRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  @override
  void dispose() {
    // TODO: implement dispose
    _httpClient.close();
  }

  @override
  Future<List<NewsModel>> getNews({String country = "us"}) async {
    final url =
        BASE_URl + "top-headlines?country=" + country + "&apiKey=" + api_key;

    final response = await _httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = convert.jsonDecode(response.body);
      final List results = data["articles"];
      final List<NewsModel> news =
          results.map((e) => NewsModel.fromMap(e)).toList();
      return news;
    }
    return [];
  }
}
