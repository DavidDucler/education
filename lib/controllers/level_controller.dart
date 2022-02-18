import 'package:educamer/ad_state.dart';
import 'package:educamer/models/matiere.dart';
import 'package:educamer/services/single_level_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LevelController extends GetxController with StateMixin<List<Matiere>> {
  final SingleLevelService singleLevelService = SingleLevelService();
  final AdState adState = Get.find();
  BannerAd bannerAd;
  RxBool loadBanner = true.obs;

  RxList<Matiere> listMatiere = <Matiere>[].obs;
  RxBool loading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    adState.initialization.then((value) {
      bannerAd = BannerAd(
        size: AdSize(width: 400, height: 100),
        adUnitId: BannerAd.testAdUnitId,
        listener: adState.adListener,
        request: AdRequest(),
      )..load();
      loadBanner.value = false;
    });
  }

  @override
  void onClose() {
    bannerAd != null ? bannerAd.dispose() : print('not loaded');
    super.onClose();
  }

  Future<void> getLevelMatieres({String collectionName}) async {
    change(null, status: RxStatus.loading());
    try {
      listMatiere.value =
          await singleLevelService.getAll(collectionName: collectionName);
      print(listMatiere);
      if (listMatiere.length == 0) {
        change(null, status: RxStatus.empty());
      } else {
        change(listMatiere, status: RxStatus.success());
      }
    } on SingleLevelException catch (e) {
      change(null, status: RxStatus.error(e.message));
    }
  }
}
