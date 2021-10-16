import 'package:news_app/models/news_model.dart';

import '../repositories.dart';

abstract class BaseNewsRepository extends BaseRepository {
  Future<List<NewsModel>> getNews({String country});
}
