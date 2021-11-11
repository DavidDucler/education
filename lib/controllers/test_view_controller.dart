import 'package:educamer/controllers/test_controller.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TestViewController extends GetxController {
  final TestController testController = Get.find();

  @override
  void onInit() {
    testController.rewardedAd != null
        ? testController.rewardedAd.show(
            onUserEarnedReward: (RewardedAd ad, RewardItem rewardedItem) {
            print('${rewardedItem.amount}');
            print('${rewardedItem.type}');
          })
        : print('add not loaded');

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    testController.rewardedAd.dispose();
    super.onClose();
  }
}
