import 'dart:convert';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=sa&category=business&apiKey=f0368d0e378940afb38467df233e6f17"));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element["title"] == null ? "" : element["title"],
              author: element["author"] ?? "",
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["context"] == null ? "" : element["context"]);
          news.add(articleModel);
        }
      });
    }
  }
}
