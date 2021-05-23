import 'package:flutter/material.dart';
import 'package:word_pair/view/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "WordPair",
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}
