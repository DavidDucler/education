import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:educamer/ad_state.dart';
import 'package:educamer/models/test.dart';
import 'package:educamer/services/test_service.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

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
  bool loadMore = false;
  RxDouble download = 0.0.obs;
  RxBool loadDown = false.obs;

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
        if (testList.length < numberToloadAtTime.value) {
          loadMore = false;
        } else {
          loadMore = true;
          lastFetchDocument = initialList[initialList.length - 1];
          print(lastFetchDocument.data());
        }
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
        change(null, status: RxStatus.error('Aucun Résultat'));
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
    List<Test> nextTest = [];
    try {
      // testList.value =
      newFetchedList = await testService.getNextTestList(
        collectionName: collectionName,
        lastFetchDocument: initialList.isNotEmpty ? lastFetchDocument : null,
        numberToLoadAtTime: numberToloadAtTime.value,
      );
      print(newFetchedList.toString());
      newFetchedList.forEach((element) {
        testList.add(Test.fromMap(element.data()));
      });
      
      if (newFetchedList.length <= numberToloadAtTime.value) {
        loadMore = false;
        change(testList, status: RxStatus.loadingMore());
      } else {
        change(testList, status: RxStatus.loadingMore());
        loadMore = true;
        print('load more');
        lastFetchDocument = newFetchedList[newFetchedList.length - 1];
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

  Future<void> downloadFile({String fileUrl}) async {
    String name = fileUrl.split('/').last;
    name = name.split('?').first;
    print(name);
    final appStorage = await getApplicationDocumentsDirectory();
    final File file = File('${appStorage.path}/$name');
    print(appStorage.path);
    loadDown.value = true;
    try {
      final response = await Dio().get(
        fileUrl,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
          receiveTimeout: 0,
        ),
        onReceiveProgress: (count, total) {
          var a = (count / total);
          print(a);
          download.value = a;
        },
      );
      if (response.statusCode == 200) {
        print(response.statusMessage);
        print(response.data);
        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();
        loadDown.value = false;
        download.value = 0.0;
        print(file.path);
        OpenFile.open(file.path);
      } else {
        print('error');
      }
    } on DioError catch (e) {
      loadDown.value = false;
      Get.showSnackbar(
        GetBar(
          title: 'Message',
          message: 'Verifier votre connection internet et ressayer',
          duration: Duration(seconds: 5),
        ),
      );
    } on FileSystemException catch (e) {
      loadDown.value = false;
      Get.showSnackbar(
        GetBar(
          title: 'Message',
          message: 'Verifier votre connection internet et ressayer',
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}

class TestException implements Exception {
  final String message;
  TestException({this.message});
}
