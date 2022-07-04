import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'view/main_page.dart';
import 'view_model/theme_change.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final ThemeChangeVM _themevm = ThemeChangeVM();

  @override
  build(BuildContext context, WidgetRef ref) {
    _themevm.getCurrentTheme(ref);
    final _isDarkMode = ref.watch(isDarkModeProvider) ?? false;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _isDarkMode
          ? ThemeData.dark()
          : ThemeData(primarySwatch: Colors.blue),
      home: MainPage(
        title: 'Repository Search',
        isDarkMode: _isDarkMode,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
    );
  }
}
