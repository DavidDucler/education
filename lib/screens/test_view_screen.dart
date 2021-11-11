//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'dart:async';

import 'package:educamer/controllers/test_controller.dart';
import 'package:educamer/controllers/test_view_controller.dart';
import 'package:educamer/models/test.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewTestScreen extends StatefulWidget {
  final String id;
  final Test test;
  const ViewTestScreen({Key key, @required this.test, this.id})
      : super(key: key);

  @override
  _ViewTestScreenState createState() => _ViewTestScreenState();
}

class _ViewTestScreenState extends State<ViewTestScreen> {
  final TestViewController testViewController = Get.put(TestViewController());
  final TestController testController = Get.find();
  bool isLoading = true;

  @override
  void initState() {
    //testController.interstitialAd.show();
    /* testController.loadAd.isTrue
        ? testController.rewardedAd.show(
            onUserEarnedReward: (RewardedAd ad, RewardItem rewardedItem) {
            print('${rewardedItem.amount}');
            print('${rewardedItem.type}');
          })
        : print('load failed'); */

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*  loadDocument() async {
    pdfDocument = await PDFDocument.fromURL(
      widget.test.epreuve,
      cacheManager: CacheManager(
        Config(
          "customCacheKey",
          stalePeriod: const Duration(days: 2),
          maxNrOfCacheObjects: 10,
        ),
      ),
    );
    setState(() {
      isLoading = false;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.test.sequence + widget.test.schoolname,
          style: TextStyle(fontSize: 12),
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
              if (await canLaunch(widget.test.epreuve)) {
                await launch(widget.test.epreuve);
              } else {
                Get.snackbar('Messae', 'Epreuve non disponible');
              }
            },
            icon: Icon(
              Icons.download,
              color: Colors.white,
            ),
            label: Text(
              'Telecharger',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                /* Expanded(
                  child: PDFViewer(
                    document: pdfDocument,
                    zoomSteps: 10,
                    scrollDirection: Axis.vertical,
                    showPicker: false,
                    navigationBuilder:
                        (context, page, totalPages, jumpToPage, animateToPage) {
                      return ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.first_page,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              jumpToPage(page: 0);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_back,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              animateToPage(page: page - 2);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              animateToPage(page: page);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.last_page,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              jumpToPage(page: totalPages - 1);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ), */
              ],
            ),
    );
  }
}
