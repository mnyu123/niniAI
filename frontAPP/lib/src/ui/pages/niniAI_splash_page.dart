import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'niniAI_home_page.dart'; // 홈 화면으로 이동하기 위한 페이지

class niniAISplashPage extends StatefulWidget {
  @override
  _niniAISplashPageState createState() => _niniAISplashPageState();
}

class _niniAISplashPageState extends State<niniAISplashPage> {
  @override
  void initState() {
    super.initState();
    // 3초 후 홈 페이지로 이동
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => niniAIHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Lottie.asset(
          'assets/animations/splash_animation.json',
          fit: BoxFit.cover, // 또는 BoxFit.contain: 애니메이션 비율에 맞게 조정됨
        ),
      ),
    );
  }
}
