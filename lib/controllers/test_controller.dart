import 'package:educamer/ad_state.dart';
import 'package:educamer/models/test.dart';
import 'package:educamer/services/test_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TestController extends GetxController {
  final TestService testService = TestService();
  RxList<Test> testList = <Test>[].obs;
  RxBool loading = false.obs;
  final AdState adState = Get.find();
  InterstitialAd interstitialAd;
  RewardedAd rewardedAd;
  BannerAd bannerAd;
  RxBool loadAd = false.obs;
  List<Object> listTest;
  @override
  void onInit() {
    createRewardedLoad();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAllTest({String collectionName}) async {
    loading.value = true;
    try {
      /* listTest = List.from(
          await testService.getAllTest(collectionName: collectionName));
      for (int i = 0; i <= listTest.length - 1; i--) {
        listTest.insert(
            i,
            BannerAd(
                size: AdSize.fullBanner,
                adUnitId: BannerAd.testAdUnitId,
                listener: adState.adListener,
                request: AdRequest())..load());
      } */
      testList.value =
          await testService.getAllTest(collectionName: collectionName);
      loading.value = false;
    } on FirebaseException catch (e) {
      print(e.message);
    } finally {
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

  Future<void> createRewardedAd() async {
    RewardedAd.loadWithAdManagerAdRequest(
      adUnitId: adState.rewardedAd,
      adManagerRequest: AdManagerAdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          this.rewardedAd = ad;
          loadAd.value = true;
          rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedAd ad) =>
                print('$ad onAdShowedFullScreenContent.'),
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              print('$ad onAdDismissedFullScreenContent.');
              //ad.dispose();
              // loadAd.value = false;
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              print('$ad onAdFailedToShowFullScreenContent: $error');
              // ad.dispose();
              loadAd.value = false;
            },
            onAdImpression: (RewardedAd ad) =>
                print('$ad impression occurred.'),
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          loadAd.value = false;
        },
      ),
    );
  }

  void createRewardedLoad() {
    loadAd.value = true;
    RewardedAd.load(
      adUnitId: RewardedAd.testAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          rewardedAd = ad;
          loadAd.value = false;
          rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (RewardedAd ad) =>
                print('$ad onAdShowedFullScreenContent.'),
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              print('$ad onAdDismissedFullScreenContent.');
              ad.dispose();
              createRewardedLoad();
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              print('$ad onAdFailedToShowFullScreenContent: $error');
              ad.dispose();
              loadAd.value = false;
            },
            onAdImpression: (RewardedAd ad) =>
                print('$ad impression occurred.'),
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          loadAd.value = false;
        },
      ),
    );
  }

  void createRewardedAdTestView() async {
    if (rewardedAd != null) {
      rewardedAd.dispose();
      RewardedAd.load(
        adUnitId: RewardedAd.testAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            rewardedAd = ad;
            loadAd.value = false;
            rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (RewardedAd ad) =>
                  print('$ad onAdShowedFullScreenContent.'),
              onAdDismissedFullScreenContent: (RewardedAd ad) {
                print('$ad onAdDismissedFullScreenContent.');
                // ad.dispose();
                loadAd.value = false;
              },
              onAdFailedToShowFullScreenContent:
                  (RewardedAd ad, AdError error) {
                print('$ad onAdFailedToShowFullScreenContent: $error');
                //ad.dispose();
                loadAd.value = false;
              },
              onAdImpression: (RewardedAd ad) =>
                  print('$ad impression occurred.'),
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            loadAd.value = false;
          },
        ),
      );
    } else {
      RewardedAd.load(
        adUnitId: RewardedAd.testAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            rewardedAd = ad;
            loadAd.value = false;
            rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (RewardedAd ad) =>
                  print('$ad onAdShowedFullScreenContent.'),
              onAdDismissedFullScreenContent: (RewardedAd ad) {
                print('$ad onAdDismissedFullScreenContent.');
                // ad.dispose();
                loadAd.value = false;
              },
              onAdFailedToShowFullScreenContent:
                  (RewardedAd ad, AdError error) {
                print('$ad onAdFailedToShowFullScreenContent: $error');
                //ad.dispose();
                loadAd.value = false;
              },
              onAdImpression: (RewardedAd ad) =>
                  print('$ad impression occurred.'),
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            loadAd.value = false;
          },
        ),
      );
    }
  }

  void showRewardedAdd() async {
    if (rewardedAd != null) {
      rewardedAd.dispose();
    }
  }
}
