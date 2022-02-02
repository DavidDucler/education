import 'package:educamer/ad_state.dart';
import 'package:educamer/screens/splashscreen.dart';
import 'package:educamer/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  Get.lazyPut(() => AdState(initialization: initFuture));
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends GetWidget<AdState> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SujetCam',
      defaultTransition: Transition.fadeIn,
      transitionDuration: Duration(seconds: 1),
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(0xFF4ACF70),
        appBarTheme: AppBarTheme(),
        textTheme: GoogleFonts.nunitoTextTheme(TextTheme()),
      ),
      home: SplashScreen(),
    );
  }
}
