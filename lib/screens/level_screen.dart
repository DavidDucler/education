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
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(.25),
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(bottomLeft: Radius.elliptical(16, 16.0))),
        title: Text(
          widget.level.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        //backgroundColor: Color(0xFF4ACF70),
      ),
      body: levelController.obx(
        (state) => GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    url: widget.level.name + '-' + state[index].name,
                  ),
                );
              },
              matiere: Matiere(
                  name: state[index].name,
                  epreuves: state[index].epreuves,
                  image: state[index].image),
            ),
          ),
        ),
        onLoading: Center(
          child: CircularProgressIndicator(),
        ),
        onEmpty: Center(
          child: Text(
            'Oups,Aucune matières disponibles pour cette classe ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        onError: (error) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            IconButton(
              onPressed: () {
                levelController.getLevelMatieres(
                    collectionName: widget.level.name);
              },
              icon: Icon(
                Icons.restart_alt,
                color: Theme.of(context).primaryColor,
                size: 28,
              ),
            ),
          ],
              ),
      ),
    );
  }
}
