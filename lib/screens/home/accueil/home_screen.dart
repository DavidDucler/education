import 'package:educamer/ad_state.dart';
import 'package:educamer/controllers/home_screen_controller.dart';
import 'package:educamer/models/niveau.dart';
import 'package:educamer/screens/level_screen.dart';
import 'package:educamer/widgets/build_niveau.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
  bool logIn = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            'EDUCAMER',
            style: TextStyle(
              color: Colors.lightGreen,
            ),
          ),
          pinned: true,
          floating: true,
          forceElevated: true,
          backgroundColor: Colors.black,
          actions: [
            Row(
              children: [
                Text('Session'),
                Switch(
                  value: logIn,
                  onChanged: (value) {
                    setState(() {
                      logIn = value;
                    });
                  },
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.white,
                )
              ],
            )
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
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
                        color: Colors.green,
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
                      'c\'est gratuit et tout se fait en quelques clics.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                title: Text(
                  'Quelques conseils pour reussir son examen!!!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                children: [
                  ListTile(
                    title: Text(
                      'Essayer : rester calme et de prenez des inspirations profondes ou respirez profond??ment.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Lisez tout l???examen avant de commencer.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'G??rer votre temps.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Passez ?? la question suivante si vous bloquez sur une question.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Lisez les questions attentivement et assurez-vous que vous r??pondez ?? chaque question correctement.',
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'V??rifiez vos r??ponses surtout si vous avez fini t??t.',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
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
              : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  staggeredTileBuilder: (int index) => StaggeredTile.count(
                    1,
                    index.isEven ? 2 : 1,
                  ),
                  itemBuilder: (context, int index) {
                    return BuildNiveau(
                      onTap: () {
                        homeScreenController.createIntertitialAd();
                        Get.to(() => LevelScreen(
                            level: homeScreenController.listLevel[index]));
                      },
                      niveau: Niveau(
                        name: homeScreenController.listLevel[index].name,
                        nbEpreuves:
                            homeScreenController.listLevel[index].nbEpreuves,
                      ),
                    );
                  },
                  itemCount: homeScreenController.listLevel.length,
                ),
        )
      ],
    );
  }
}
