import 'dart:async';

import 'package:educamer/data/img.dart';
import 'package:educamer/screens/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Get.offAll(
        () => OnbaordingScreen(),
        transition: Transition.fadeIn,
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          Img.get("logo.png"),
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
