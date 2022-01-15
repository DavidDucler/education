import 'package:educamer/controllers/home_screen_controller.dart';
import 'package:educamer/controllers/level_controller.dart';
import 'package:educamer/controllers/test_controller.dart';
import 'package:educamer/models/matiere.dart';
import 'package:educamer/models/niveau.dart';
import 'package:educamer/screens/page_matiere.dart';
import 'package:educamer/widgets/build_matiere.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LevelScreen extends StatefulWidget {
  final Niveau level;
  const LevelScreen({Key key, @required this.level}) : super(key: key);

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  final LevelController levelController = Get.put(LevelController());
  final TestController testController = Get.put(TestController());
  final HomeScreenController homeScreenController = Get.find();
  @override
  void initState() {
    showIntertitialAd();
    super.initState();
    levelController.getLevelMatieres(collectionName: widget.level.name);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void showIntertitialAd() {
    homeScreenController.interstitialAd?.show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.level.name),
        elevation: 0,
      ),
      body: Obx(
        () => levelController.loading.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                itemCount: levelController.listMatiere.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => Obx(
                  () => BuildMatiere(
                    onTap: () {
                      testController.createRewardedLoad();
                      Get.to(
                        () => PageMatiere(
                          url: widget.level.name +
                              '-' +
                              levelController.listMatiere[index].name,
                        ),
                      );
                    },
                    matiere: Matiere(
                        name: levelController.listMatiere[index].name,
                        epreuves: levelController.listMatiere[index].epreuves,
                        image: levelController.listMatiere[index].image),
                  ),
                ),
              ),
      ),
    );
  }
}
