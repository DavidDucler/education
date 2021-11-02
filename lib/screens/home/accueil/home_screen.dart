import 'package:educamer/controllers/home_screen_controller.dart';
import 'package:educamer/models/niveau.dart';
import 'package:educamer/screens/level_screen.dart';
import 'package:educamer/widgets/build_niveau.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bienvenue sur Educamer',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Profitez de notre banque d\'epreuves pour vos differentes matieres.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'c\'est gratuit et tout se fait en seul clic',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  'Classes Disponibles',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(
          () => homeScreenController.loading.isTrue
              ? SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                )
              : SliverGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: List.generate(
                    homeScreenController.listLevel.length,
                    (index) => BuildNiveau(
                      onTap: () {
                        Get.to(() => LevelScreen(
                            level: homeScreenController.listLevel[index]));
                      },
                      niveau: Niveau(
                        name: homeScreenController.listLevel[index].name,
                        nbEpreuves:
                            homeScreenController.listLevel[index].nbEpreuves,
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
