import 'package:educamer/ad_state.dart';
import 'package:educamer/models/niveau.dart';
import 'package:educamer/services/all_collection_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreenController extends GetxController {
  final AllLevelService _allLevelService = AllLevelService();
  final AdState adState = Get.find();
  List<Niveau> listLevel = [];
  RxBool loading = true.obs;
  BannerAd bannerAd;
  RxBool isLoaded = true.obs;
  InterstitialAd interstitialAd;
  RxBool loadAd = false.obs;
  RxList<Object> listLevelAds = <Object>[].obs;

  @override
  void onInit() {
    createIntertitialAd();
    super.onInit();
    loading.value = true;
  }

  @override
  void onClose() {
    bannerAd?.dispose();
    interstitialAd?.dispose();
    super.onClose();
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
        size: AdSize.fullBanner,
      )..load());
    });
  }

  Future<void> getAllLevels({BannerAd bannerAd}) async {
    loading.value = true;
    try {
      listLevel = await _allLevelService.allLevels();
      loading.value = false;
    } on FirebaseException catch (e) {
      print(e.message);
      loading.value = false;
    }
  }

  void createIntertitialAd() {
    loadAd.value = true;
    InterstitialAd.load(
      adUnitId: adState.intertialAd,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          this.interstitialAd = ad;
          loadAd.value = false;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) {
              print('$ad onAdShowedFullScreenContent.');
            },
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              print('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
              loadAd.value = false;
              createIntertitialAd();
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              print('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
              loadAd.value = false;
            },
            onAdImpression: (InterstitialAd ad) =>
                print('$ad impression occurred.'),
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
          loadAd.value = false;
        },
      ),
    );
  }
}
