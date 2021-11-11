import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<InitializationStatus> initialization;

  AdState({
    this.initialization,
  });
  String get bannerId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/6300978111';

  String get intertialAd => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/1033173712';
  String get rewardedAd => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/5224354917';

  BannerAdListener get adListener => _adListener;

  BannerAdListener _adListener = BannerAdListener(
    onAdLoaded: (ad) => print('adLoaded:' + '${ad.adUnitId}'),
    onAdOpened: (ad) => print('adopened:' + '${ad.adUnitId}'),
  );
}
