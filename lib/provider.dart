import 'dart:convert';

import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;

import 'data/repository_data.dart';

StateProvider<String> repositoryQueryProvider = StateProvider((ref) => "");

FutureProvider<RepositoryData> apiProvider = FutureProvider(
  (ref) async {
    final repositoryData = ref.watch(repositoryQueryProvider);
    // 空白をクエリ用に+に変換する処理
    if (repositoryData != "") {
    } else if (repositoryData.contains(" ")) {
      repositoryData.replaceAll(" ", "+");
    } else if (repositoryData.substring(0, 0) == "+") {
      repositoryData.replaceFirst("+", "");
    } else {
      throw Exception("Form is Empty");
    }
    final apiUrl =
        "https://api.github.com/search/repositories?q=$repositoryData";
    final apiUri = Uri.parse(apiUrl);
    http.Response response = await http.get(apiUri);

    if (response.statusCode != 200) {
      throw Exception("No Repository: $repositoryData");
    }

    var jsonData = json.decode(response.body);
    return RepositoryData.fromJson(jsonData);
  },
);

AutoDisposeFutureProviderFamily<RepositoryData, String> apiFamilyProvider =
    FutureProvider.autoDispose.family<RepositoryData, String>(
  (ref, repositoryData) async {
    // 空白をクエリ用に+に変換する処理
    if (repositoryData != "") {
    } else if (repositoryData.contains(" ")) {
      repositoryData.replaceAll(" ", "+");
    } else if (repositoryData.substring(0, 0) == "+") {
      repositoryData.replaceFirst("+", "");
    } else {
      throw Exception("Form is Empty");
    }
    final apiUrl =
        "https://api.github.com/search/repositories?q=$repositoryData";
    final apiUri = Uri.parse(apiUrl);
    http.Response response = await http.get(apiUri);

    if (response.statusCode != 200) {
      throw Exception("No Repository: $repositoryData");
    }

    var jsonData = json.decode(response.body);
    return RepositoryData.fromJson(jsonData);
  },
);
