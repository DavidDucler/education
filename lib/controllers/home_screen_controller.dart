import 'package:educamer/ad_state.dart';
import 'package:educamer/services/all_collection_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreenController extends GetxController {
  final AllLevelService _allLevelService = AllLevelService();
  final AdState adState = Get.find();
  List<Object> listLevel = [];
  RxBool loading = true.obs;
  BannerAd bannerAd;
  RxBool isLoaded = true.obs;

  RxList<Object> listLevelAds = <Object>[].obs;

  @override
  void onInit() {
    super.onInit();
    loading.value = true;
  }

  @override
  void onReady() {
    super.onReady();
    adState.initialization.then((status) {
      bannerAd = BannerAd(
        adUnitId: adState.bannerId,
        listener: adState.adListener,
        request: AdRequest(),
        size: AdSize(width: 300, height: 100),
      )..load();
      isLoaded.value = false;
      getAllLevels(
          bannerAd: BannerAd(
        adUnitId: adState.bannerId,
        listener: adState.adListener,
        request: AdRequest(),
        size: AdSize(width: 300, height: 100),
      )..load());
    });
  }

  Future<void> getAllLevels({BannerAd bannerAd}) async {
    loading.value = true;
    try {
      listLevel = List.from(await _allLevelService.allLevels());
      /* for (int i = listLevel.length - 2; i >= 1; i -= 8) {
        listLevel.insert(i, bannerAd);
      } */
      // listLevelAds.value = List.from(listLevel.value);
      loading.value = false;
    } on FirebaseException catch (e) {
      print(e.message);
      loading.value = false;
    }
  }
}
