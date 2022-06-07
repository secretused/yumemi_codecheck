import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_page_vm.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final TextEditingController _queryTextController = TextEditingController();
  final MainPageVM _vm = MainPageVM();

  @override
  void initState() {
    super.initState();
    _vm.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    final data = _vm.repositoryDataWithFamily(_vm.repositoryData);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                        left: 8.0, right: 10.0, bottom: 15.0),
                    child: TextField(
                      controller: _queryTextController,
                      enabled: true,
                      style: const TextStyle(color: Colors.black),
                      obscureText: false,
                      maxLines: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () =>
                        _vm.onPostalCodeChaged(_queryTextController.text),
                    child: const Text('検索'),
                  ),
                )
              ],
            ),
            (() {
              if (data.value != null) {
                return Text(
                    "Total Count: ${data.value!.total_count.toString()}");
              } else {
                return Text('Non Repository');
              }
            })(),
            Expanded(
              child: _vm.repositoryDataWithFamily(_vm.repositoryData).when(
                    data: (data) => ListView.separated(
                      itemCount: data.items.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.items[index].full_name),
                          ],
                        ),
                        subtitle: Text(
                            data.items[index].description ?? "No Description"),
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
}
