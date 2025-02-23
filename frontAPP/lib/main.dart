import 'package:flutter/material.dart';
import 'package:niniaifrontapp/src/ui/pages/niniAI_splash_page.dart';
import 'src/ui/pages/niniAI_home_page.dart';

void main() {
  runApp(niniAIApp());
}

class niniAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'niniAI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: niniAISplashPage(),
    );
  }
}
