import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/main_page_vm.dart';
import '../view_model/theme_change.dart';
import 'next_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({
    Key? key,
    required this.title,
    required this.isDarkMode,
  }) : super(key: key);

  final String title;
  final bool isDarkMode;

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final TextEditingController _queryTextController = TextEditingController();
  static const String _sharedPreferencesKey = 'isDark';

  final MainPageVM _vm = MainPageVM();
  final ThemeChangeVM _themevm = ThemeChangeVM();

  @override
  void initState() {
    super.initState();
    _vm.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final data = _vm.repositoryDataWithFamily(_vm.repositoryQuery);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: size.height * 0.125,
              child: DrawerHeader(
                padding: EdgeInsets.zero,
                child: const Text(
                  '設定',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                    color: widget.isDarkMode ? Colors.black12 : Colors.blue),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.5),
                ),
              ),
              child: ListTile(
                title: const Text("テーマを切り替える"),
                onTap: () {
                  final _isDarkMode = ref.watch(isDarkModeProvider) ?? false;
                  ref
                      .read(isDarkModeProvider.state)
                      .update((state) => !_isDarkMode);
                  _themevm.onThemaChaged(_sharedPreferencesKey, !_isDarkMode);
                },
              ),
            ),
          ],
        ),
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
                      style: TextStyle(
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black),
                      obscureText: false,
                      maxLines: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () =>
                        _vm.onQueryChaged(_queryTextController.text),
                    child: const Text('検索'),
                  ),
                ),
              ],
            ),
            (() {
              if (data.value != null) {
                return Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.025),
                  child: Text(
                      "Total Count: ${data.value!.total_count.toString()}"),
                );
              } else {
                return const Text('Non Repository');
              }
            })(),
            Expanded(
              child: _vm.repositoryDataWithFamily(_vm.repositoryQuery).when(
                    data: (data) => ListView.separated(
                      itemCount: data.items.length,
                      itemBuilder: (context, index) => ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.items[index].full_name),
                            ],
                          ),
                          subtitle: Text(data.items[index].description ??
                              "No Description"),
                          onTap: () {
                            _vm.onListTapped(data.items[index]);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailPage();
                                },
                              ),
                            );
                          }),
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.black,
                      ),
                    ),
                    error: (error, stack) => Text(
                      error.toString(),
                    ),
                    loading: () => const CupertinoActivityIndicator(
                      radius: 30,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
