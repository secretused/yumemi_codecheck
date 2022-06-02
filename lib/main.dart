import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_codecheck/provider.dart';

import 'setting.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Github Repositories Search'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  get context => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositoryQuery =
        ref.watch(apiFamilyProvider(ref.watch(repositoryQueryProvider)));
    TextEditingController _queryTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 10.0, bottom: 20.0),
                    child: TextField(
                      controller: _queryTextController,
                      enabled: true,
                      style: TextStyle(color: Colors.black),
                      obscureText: false,
                      maxLines: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () => onRepositoryQueryChanged(
                        _queryTextController.text, ref),
                    child: const Text('検索'),
                  ),
                )
              ],
            ),
            Expanded(
              child: repositoryQuery.when(
                data: (data) => ListView.separated(
                  itemCount: data.items.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.items[index].full_name),
                      ],
                    ),
                    subtitle:
                        Text(data.items[index].description ?? "No Description"),
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                  ),
                ),
                error: (error, stack) => Text(
                  error.toString(),
                ),
                loading: () => AspectRatio(
                  aspectRatio: 1,
                  child: const CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onRepositoryQueryChanged(String text, WidgetRef ref) {
    try {
      ref.watch(repositoryQueryProvider.notifier).update((state) => text);
      print(text);
    } catch (e) {
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return ErrorModal(error_message: e.toString());
        },
      );
    }
  }
}
