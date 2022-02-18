import 'package:educamer/controllers/test_controller.dart';
import 'package:educamer/widgets/test_download_outline.dart';
import 'package:educamer/widgets/testwidget.dart';
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

  String sequence;
  String year;

  List<String> years = [
    '2000-2001',
    '2001-2002',
    '2002-2003',
    '2003-2004',
    '2004-2005',
    '2005-2006',
    '2006-2007',
    '2007-2008',
    '2008-2009',
    '2009-2010',
    '2010-2011',
    '2011-2012',
    '2012-2013',
    '2013-2014',
    '2014-2015',
    '2015-2016',
    '2016-2017',
    '2017-2018',
    '2018-2019',
    '2019-2020',
    '2020-2021',
    '2021-2022',
    '2022-2023',
    '2023-2024',
    '2024-2025',
    '2025-2026',
    '2027-2028',
    '2028-2029',
    '2029-2030',
  ];
  List<String> sequences = [
    'première sequence',
    '2 ième sequence',
    '3 ième sequence',
    '4 ième sequence',
    '5 ième sequence',
    '6 ième sequence',
    'examen officiel',
    'epreuve zéro',
    'Bac Blanc',
    'première sequence mini session',
    '2 ième sequence mini session',
    '3 ième sequence mini session',
    '4 ième sequence mini session',
    '5 ième sequence mini session',
    '6 ième sequence mini session',
  ];

  TextEditingController name = TextEditingController();
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
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (testController.loadMore == true) {
        print(testController.lastFetchDocument.data());
        testController.fetchNextTest(collectionName: widget.url);
      }
    }
  }

  void showRewardedAdd() {
    testController.rewardedAd?.show(
        onUserEarnedReward: (RewardedAd ad, RewardItem rewardedItem) {
      print('${rewardedItem.amount}');
      print('${rewardedItem.type}');
    });
  }

  Future<void> makeSearch() async {
    testController.makeSearch(
      collectionName: widget.url,
      schoolname: name.text,
      annee: year,
      sequence: sequence,
    );
  }

  void onChangeYear() {
    var contains =
        testController.testList.where((test) => test.annee == year).toList();
    if (contains.isEmpty) {
      print('Aucun resultat');
    } else {
      setState(() {
        testController.testList.value = contains;
      });

      print(contains);
      print('trouve');
    }
  }

  void onChangeSequence() {
    var contains = testController.testList
        .where((test) => test.sequence.toLowerCase().contains(sequence))
        .toList();
    if (contains.isEmpty) {
      print('Aucun resultat');
    } else {
      setState(() {
        testController.testList.value = contains;
      });

      print(contains);
      print('trouve');
    }
  }

  void onChanged() {
    var contains = testController.testList
        .where((test) =>
            test.schoolname.toLowerCase().contains(name.text.toLowerCase()))
        .toList();
    if (contains.isEmpty) {
      print('Aucun resultat');
    } else {
      setState(() {
        testController.testList.value = contains;
      });

      print(contains);
      print('trouve');
    }
  }

  void reset() {
    testController.getAllTest(collectionName: widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF4ACF70),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(bottomLeft: Radius.elliptical(16, 16.0))),
        actions: [
          IconButton(
            onPressed: () =>
                testController.getAllTest(collectionName: widget.url),
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                StatefulBuilder(builder: (context, StateSetter ss) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0)),
                    ),
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                height: 5,
                                width: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Filtrer les Epreuves',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  //reset();
                                  ss(() {
                                    year = null;
                                    sequence = null;
                                    name.clear();
                                  });
                                },
                                child: Text(
                                  'Reset',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Filtrer par le nom de l\'etablissement',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            cursorColor: Colors.black,
                            controller: name,
                            onChanged: (String value) {
                              //  onChanged();
                            },
                            decoration: InputDecoration(
                              labelText: 'nom du lycee ou college',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              hintText: 'College vogt',
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Filtrer par sequence',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: sequence,
                            onChanged: (String val) {
                              ss(() {
                                sequence = val;
                              });
                              // onChangeSequence();
                            },
                            items: sequences
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Filtrer par annee',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: year,
                            onChanged: (String val) {
                              ss(() {
                                year = val;
                              });
                              // onChangeYear();
                            },
                            items: years
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  makeSearch().then((value) => Get.back());
                                },
                                child: Text(
                                  'Appliquer',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                backgroundColor: Colors.transparent,
                enableDrag: true,
                elevation: 10.0,
                isDismissible: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                ),
              );
            },
            icon: Icon(Icons.filter_list_alt),
          ),
        ],
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
              itemBuilder: (context, index) => TestWidget(
                    test: state[index],
                    onpress: () => Get.to(
                      () => DownloadOutlineTestPage(
                        test: state[index],
                      ),
                    ),
                  ) /* Card(
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
            ), */
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
