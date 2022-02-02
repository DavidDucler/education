import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educamer/ad_state.dart';
import 'package:educamer/models/test.dart';
import 'package:educamer/services/test_service.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TestController extends GetxController with StateMixin<List<Test>> {
  final TestService testService = TestService();
  RxList<Test> testList = <Test>[].obs;
  RxBool loading = false.obs;
  final AdState adState = Get.find();
  InterstitialAd interstitialAd;
  RewardedAd rewardedAd;
  BannerAd bannerAd;
  RxBool loadAd = false.obs;
  QueryDocumentSnapshot lastFetchDocument;
  List<QueryDocumentSnapshot> initialList;
  List<QueryDocumentSnapshot> newFetchedList;
  RxBool loadMore;

  RxInt numberToloadAtTime = 10.obs;
  RxInt numberToloadFromNextTime = 20.obs;
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
    change(null, status: RxStatus.loading());
    try {
      // testList.value =
      initialList = [];
      testList.value = [];
      initialList = await testService.getInitialTestList(
        collectionName: collectionName,
        lastFetchDocument: lastFetchDocument,
        numberToLoadAtTime: numberToloadAtTime.value,
      );
      initialList.forEach((element) {
        testList.add(Test.fromMap(element.data()));
      });
      if (testList.length == 0) {
        change(null, status: RxStatus.empty());
      } else {
        change(testList, status: RxStatus.success());
        lastFetchDocument = initialList[initialList.length - 1];
        print(initialList.length - 1);
      }
     
    } on TestException catch (e) {
      print(e.message);
      change(null, status: RxStatus.error(e.message));
    }
  }

   Future<void> makeSearch(
      {String collectionName,
      String schoolname,
      String annee,
      String sequence}) async {
    change(null, status: RxStatus.loading());
    try {
      // testList.value =
      initialList = [];
      testList.value = [];
      initialList = await testService.makeSearch(
        schoolname: schoolname,
        sequence: sequence,
        annee: annee,
        collectionName: collectionName,
        lastFetchDocument: lastFetchDocument,
        numberToLoadAtTime: numberToloadAtTime.value,
      );
      initialList.forEach((element) {
        testList.add(Test.fromMap(element.data()));
      });
      if (testList.length == 0) {
        change(null, status: RxStatus.error('Aucun Resultat'));
      } else {
        change(testList, status: RxStatus.success());
        lastFetchDocument = initialList[initialList.length - 1];
        print(initialList.length - 1);
      }
    } on TestException catch (e) {
      print(e.message);
      change(null, status: RxStatus.error(e.message));
    }
  }

  Future<void> fetchNextTest({String collectionName}) async {
    // change(null, status: RxStatus.loading());
    List<Test> nextTest = [];
    try {
      // testList.value =
      newFetchedList = await testService.getNextTestList(
        collectionName: collectionName,
        lastFetchDocument: lastFetchDocument,
        numberToLoadAtTime: numberToloadAtTime.value,
      );
      print(newFetchedList.toString());
      newFetchedList.forEach((element) {
        nextTest.add(Test.fromMap(element.data()));
      });
      testList.addAll(nextTest);

      if (newFetchedList.length == 0) {
        print('load more not work');
      } else {
        print('load more');
        lastFetchDocument = newFetchedList[newFetchedList.length - 1];
        /* newFetchedList.forEach((element) {
          nextTest.add(Test.fromMap(element.data()));
        }); */
        change(testList, status: RxStatus.loadingMore());
      }
    } on TestException catch (_) {}
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
