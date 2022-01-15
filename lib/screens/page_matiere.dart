import 'package:educamer/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

class PageMatiere extends StatefulWidget {
  final String url;
  const PageMatiere({Key key, @required this.url}) : super(key: key);

  @override
  _PageMatiereState createState() => _PageMatiereState();
}

class _PageMatiereState extends State<PageMatiere> {
  final TestController testController = Get.find();

  @override
  void initState() {
    super.initState();
    testController.getAllTest(collectionName: widget.url);
    showRewardedAdd();
    //testController.createIntertitialAd();
    //testController.createRewardedAd();
  }

  void showRewardedAdd() {
    testController.rewardedAd?.show(
        onUserEarnedReward: (RewardedAd ad, RewardItem rewardedItem) {
      print('${rewardedItem.amount}');
      print('${rewardedItem.type}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.url),
        elevation: 0,
      ),
      body: Obx(
        () => testController.loading.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : testController.testList.length == 0
                ? Center(
                    child: Text(
                      'Aucune epreuve disponible',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () =>
                        testController.getAllTest(collectionName: widget.url),
                    child: ListView.builder(
                      itemCount: testController.testList.length,
                      itemBuilder: (context, index) => Card(
                        child: Container(
                          child: Obx(
                            () => ListTile(
                              onTap: () async {
                                if (await canLaunch(
                                    testController.testList[index].corrige)) {
                                  await launch(
                                      testController.testList[index].corrige);
                                  showRewardedAdd();
                                } else {
                                  Get.snackbar(
                                      'Messagee', 'Epreuve non disponible');
                                }
                              },
                              title: Text(
                                testController.testList[index].schoolname +
                                    '  ' +
                                    testController.testList[index].sequence,
                              ),
                              subtitle: Text(
                                'Annee Scolaire: ' +
                                    testController.testList[index].annee,
                              ),
                              trailing: Wrap(
                                direction: Axis.vertical,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      if (await canLaunch(testController
                                          .testList[index].corrige)) {
                                        await launch(testController
                                            .testList[index].corrige);
                                        showRewardedAdd();
                                      } else {
                                        Get.snackbar('Message',
                                            'Epreuve non disponible');
                                      }
                                    },
                                    icon: Icon(Icons.download,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
