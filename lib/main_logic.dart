import 'dart:convert';

import 'package:yumemi_codecheck/data/repository_data.dart';
import 'package:http/http.dart' as http;

class Logic {
  Future<RepositoryData> getRepositoryData(String repositoryQuery) async {
    // 空白をクエリ用に+に変換する処理
    if (repositoryQuery.substring(0, 0).isEmpty) {
      var query = repositoryQuery.replaceFirst(" ", "");
      repositoryQuery = query;
    }
    if (repositoryQuery.contains(" ")) {
      var query = repositoryQuery.replaceAll(" ", "+");
      repositoryQuery = query;
    }

    final apiUrl =
        "https://api.github.com/search/repositories?q=$repositoryQuery";
    final apiUri = Uri.parse(apiUrl);
    http.Response response = await http.get(apiUri);

    if (response.statusCode != 200) {
      throw Exception("No Repository: $repositoryQuery");
    }

    var jsonData = json.decode(response.body);
    return RepositoryData.fromJson(jsonData);
  }

  // 空ではない場合処理を通す
  bool willProceed(String repositoryQuery) {
    return repositoryQuery.isNotEmpty;
  }
}
