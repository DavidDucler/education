import 'package:educamer/controllers/level_controller.dart';
import 'package:educamer/models/matiere.dart';
import 'package:educamer/models/niveau.dart';
import 'package:educamer/screens/page_matiere.dart';
import 'package:educamer/widgets/build_niveau.dart';
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
  @override
  void initState() {
    super.initState();
    levelController.getLevelMatieres(collectionName: widget.level.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.level.name),
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
                itemBuilder: (context, index) => BuildNiveau(
                  onTap: () => Get.to(() => PageMatiere(
                      url: widget.level.name +
                          '-' +
                          levelController.listMatiere[index].name)),
                  niveau: Niveau(
                      name: levelController.listMatiere[index].name,
                      nbEpreuves: levelController.listMatiere[index].epreuves),
                ),
              ),
      ),
    );
  }
}
