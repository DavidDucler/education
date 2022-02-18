import 'package:educamer/controllers/home_screen_controller.dart';
import 'package:educamer/controllers/test_controller.dart';
import 'package:educamer/models/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DownloadOutlineTestPage extends StatefulWidget {
  final Test test;
  const DownloadOutlineTestPage({Key key, this.test}) : super(key: key);

  @override
  State<DownloadOutlineTestPage> createState() =>
      _DownloadOutlineTestPageState();
}

class _DownloadOutlineTestPageState extends State<DownloadOutlineTestPage> {
  final TestController testController = Get.find();
  final HomeScreenController homeScreenController = Get.find();
  void showIntertitialAd() {
    homeScreenController.interstitialAd?.show();
  }

  void showRewardedAdd() {
    testController.rewardedAd?.show(
        onUserEarnedReward: (RewardedAd ad, RewardItem rewardedItem) {
      print('${rewardedItem.amount}');
      print('${rewardedItem.type}');
    });
  }

  @override
  void initState() {
    super.initState();
    showIntertitialAd();
    testController.download.value = 0.0;
  }
  //For normal dialog

//For showing progress percentage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Téléchargement'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(bottomLeft: Radius.elliptical(16, 16.0))),
      ),
      body: Obx(
        () => LoadingOverlay(
          isLoading: testController.loadDown.isTrue,
          progressIndicator: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 30.0,
                  lineWidth: 5.0,
                  percent: testController.download.value,
                  center: new Text(
                    (testController.download.value * 100).toStringAsFixed(0) +
                        "%",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  progressColor: Colors.green,
                ),
                const SizedBox(height: 10),
                Text(
                  'Telechargement',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    offset: Offset(0, 5),
                    blurRadius: 14,
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Objet:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Telechargement d\'une epreuve',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Details du sujet',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Etablissement: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.test.schoolname,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Sequence: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.test.sequence,
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Annee scolaire: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.test.annee,
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.redAccent,
                        size: 32,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          'Pour télécharger l\'épreuve vous devez cliquer sur continuer pour l\'ouvrir depuis votre lecteur pdf et ensuite vous pourrez l\'enregister.Cliquer sur continuer pour obtenir votr epreuve.',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                      fixedSize: MaterialStateProperty.resolveWith(
                        (states) => Size(MediaQuery.of(context).size.width, 56),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      testController.downloadFile(fileUrl: widget.test.epreuve);
                    },
                    child: Text(
                      'Continuer',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
