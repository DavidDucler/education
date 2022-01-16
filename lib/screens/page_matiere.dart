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
  ScrollController scrollController;

  @override
  void initState() {
    print('init test');
    super.initState();
    testController.getAllTest(collectionName: widget.url);
    showRewardedAdd();
    scrollController = ScrollController()..addListener(scrollListener);
    //testController.createIntertitialAd();
    //testController.createRewardedAd();
  }

  void scrollListener() {
    if (scrollController.offset == scrollController.position.maxScrollExtent) {
      print(scrollController.offset);
      testController.fetchNextTest(collectionName: widget.url);
    }
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF4ACF70),
        title: Text(
          widget.url,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: testController.obx(
        (state) => RefreshIndicator(
          onRefresh: () =>
              testController.getAllTest(collectionName: widget.url),
          child: ListView.builder(
            controller: scrollController,
            itemCount: state.length,
            itemBuilder: (context, index) => Card(
              child: Container(
                child: Obx(
                  () => ListTile(
                    onTap: () async {
                      if (await canLaunch(state[index].corrige)) {
                        await launch(state[index].corrige);
                        showRewardedAdd();
                      } else {
                        Get.snackbar('Messagee', 'Epreuve non disponible');
                      }
                    },
                    title: Text(
                      state[index].schoolname + '  ' + state[index].sequence,
                    ),
                    subtitle: Text(
                      'Annee Scolaire: ' + state[index].annee,
                    ),
                    trailing: Wrap(
                      direction: Axis.vertical,
                      children: [
                        IconButton(
                          onPressed: () async {
                            if (await canLaunch(state[index].corrige)) {
                              await launch(state[index].corrige);
                              showRewardedAdd();
                            } else {
                              Get.snackbar('Message', 'Epreuve non disponible');
                            }
                          },
                          icon: Icon(Icons.download, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        onEmpty: Center(
          child: Text(
            'Oups,Aucune epreuves disponibles',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onError: (error) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                error,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFD3C4A),
                ),
              ),
              
              IconButton(
                onPressed: () =>
                    testController.getAllTest(collectionName: widget.url),
                icon: Icon(
                  Icons.replay_outlined,
                  color: Color(0xFF4ACF70),
                  size: 48,
                ),
              ),
            ],
          ),
        ),
        onLoading: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
