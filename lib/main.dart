import 'package:educamer/ad_state.dart';
import 'package:educamer/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final initFuture = MobileAds.instance.initialize();
  Get.lazyPut(() => AdState(initialization: initFuture));
  runApp(MyApp());
}

class MyApp extends GetWidget<AdState> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Educamer',
      defaultTransition: Transition.fadeIn,
      transitionDuration: Duration(seconds: 1),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      home: SplashScreen(),
    );
  }
}
