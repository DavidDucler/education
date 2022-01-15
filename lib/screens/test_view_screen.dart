//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'dart:async';
import 'package:educamer/controllers/test_controller.dart';
import 'package:educamer/controllers/test_view_controller.dart';
import 'package:educamer/models/test.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ViewTestScreen extends StatefulWidget {
  final String id;
  final Test test;
  const ViewTestScreen({Key key, @required this.test, this.id})
      : super(key: key);

  @override
  _ViewTestScreenState createState() => _ViewTestScreenState();
}

class _ViewTestScreenState extends State<ViewTestScreen> {
  final TestViewController testViewController = Get.put(TestViewController());
  final TestController testController = Get.find();
  bool isLoading = true;
  Timer timer;

  @override
  void initState() {
    //testController.interstitialAd.show();
    showRewardedAdd();
    super.initState();
    print(widget.test.corrige);
  }

  void showRewardedAdd() {
    testController.rewardedAd?.show(
        onUserEarnedReward: (RewardedAd ad, RewardItem rewardedItem) {
      print('${rewardedItem.amount}');
      print('${rewardedItem.type}');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.test.sequence + widget.test.schoolname,
            style: TextStyle(fontSize: 12),
          ),
          actions: [
            TextButton.icon(
              onPressed: () async {
                testController.loadAd.isTrue
                    ? print('not loaded')
                    : testController.rewardedAd.show(onUserEarnedReward:
                        (RewardedAd ad, RewardItem rewardedItem) {
                        print('${rewardedItem.amount}');
                        print('${rewardedItem.type}');
                      });
                /* if (await canLaunch(widget.test.epreuve)) {
                await launch(widget.test.epreuve);
              } else {
                Get.snackbar('Messagee', 'Epreuve non disponible');
              } */
              },
              icon: Icon(
                Icons.download,
                color: Colors.white,
              ),
              label: Text(
                'Telecharger',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
        body: Container());
  }
}
