import 'package:dio/dio.dart';
import 'package:news/models/articlesModel.dart';

class NewServises{
  final Dio dio = Dio();
  final String baseUrl='https://newsapi.org/v2/everything';
  final String apikey='1c36a32af5ab4fd78b2d7dd3511aba16';

  Future<List<Articlemodel>>getNews(String Category) async {
    try {
      // get res
      Response response = await dio.get('${baseUrl}?q=${Category}&from=2025-01-11&sortBy=publishedAt&apiKey=${apikey}');
      List<dynamic> articles = response.data["articles"];
      return articles.map((item){
        return Articlemodel.fromJson(item);
      }).toList();
    } catch (e) {
     return [];
    }
  }
}