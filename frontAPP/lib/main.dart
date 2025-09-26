// 파일: lib/main.dart

import 'package:flutter/material.dart';
import 'package:niniaifrontapp/src/providers/player_provider.dart';
import 'package:provider/provider.dart';
import 'src/providers/video_provider.dart';
import 'src/ui/pages/niniAI_splash_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoProvider()),
        ChangeNotifierProvider(create: (_) => PlayerProvider()), // 2025-09-26 추가
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
