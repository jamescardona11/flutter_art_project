import 'package:flutter/material.dart';

import 'home_page.dart';
import 'provider/settings_iw.dart';
import 'provider/settings_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: SettingsInheritedWidget(
        provider: SettingsProvider(),
        child: const HomeWidget(),
      ),
    );
  }
}
