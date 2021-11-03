import 'package:educamer/ad_state.dart';
import 'package:educamer/controllers/home_screen_controller.dart';
import 'package:educamer/models/niveau.dart';
import 'package:educamer/screens/level_screen.dart';
import 'package:educamer/widgets/build_niveau.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
               Obx(
                () => homeScreenController.isLoaded.isTrue
                    ? Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        height: 100,
                        child: AdWidget(ad: homeScreenController.bannerAd),
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
                  children: List.generate(homeScreenController.listLevel.length,
                      (index) {
                    if (homeScreenController.listLevel[index] is Niveau) {
                      return BuildNiveau(
                        onTap: () {
                          Get.to(() => LevelScreen(
                              level: (homeScreenController.listLevel[index]
                                  as Niveau)));
                        },
                        niveau: Niveau(
                          name:
                              (homeScreenController.listLevel[index] as Niveau)
                                  .name,
                          nbEpreuves:
                              (homeScreenController.listLevel[index] as Niveau)
                                  .nbEpreuves,
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        height: 200,
                        child: AdWidget(
                          key: Key(
                            homeScreenController.listLevel[index].toString(),
                          ),
                          ad: (homeScreenController.listLevel[index]
                              as BannerAd),
                        ),
                      );
                    }
                  }),
                ),
        ),
      ],
    );
  }
}
