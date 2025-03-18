// 파일: lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/providers/video_provider.dart';
import 'src/ui/pages/niniAI_splash_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoProvider()),
      ],
      child: niniAIApp(),
    ),
  );
}

class niniAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'niniAI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NotoSansKR',
      ),
      home: niniAISplashPage(),
    );
  }
}
