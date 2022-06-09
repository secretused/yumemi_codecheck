import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_codecheck/data/repository_data.dart';

import 'main_page_vm.dart';

class DetailPage extends ConsumerWidget {
  final MainPageVM _vm = MainPageVM();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _vm.setRef(ref);
    RepositoryDataItems? data = _vm.tappedRepository;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repository Detail"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipOval(
            child: Image.network(
              data.owner.avatar_url,
              width: 150,
              height: 150,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            data.full_name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 30.0,
              left: 30.0,
            ),
            child: Text(
              data.description ?? "No Description",
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text("fork数: ${data.forks_count.toString()}"),
          Text("issue数: ${data.open_issues_count.toString()}"),
          Text("star数: ${data.stargazers_count.toString()}"),
          Text("watch数: ${data.watchers_count.toString()}"),
        ],
      ),
    );
  }
}
