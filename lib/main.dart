import 'package:flutter/material.dart';
import 'package:startup_namer/random_words_widget.dart';

void main() => runApp(StartupNamerApp());

class StartupNamerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Flutter',
        theme: ThemeData(primaryColor: Colors.white),
        home: RandomWordsWidget(),
        debugShowCheckedModeBanner: false);
  }
}
