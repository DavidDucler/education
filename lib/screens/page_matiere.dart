import 'package:educamer/controllers/test_controller.dart';
import 'package:educamer/screens/test_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PageMatiere extends StatefulWidget {
  final String url;
  const PageMatiere({Key key, @required this.url}) : super(key: key);

  @override
  _PageMatiereState createState() => _PageMatiereState();
}

class _PageMatiereState extends State<PageMatiere> {
  final TestController testController = Get.put(TestController());
  @override
  void initState() {
    super.initState();
    testController.getAllTest(collectionName: widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.url),
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
                          child: ListTile(
                            onTap: () => Get.to(() => ViewTestScreen(
                                  test: testController.testList[index],
                                  id: widget.url,
                                )),
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
                                        .testList[index].epreuve)) {
                                      await launch(testController
                                          .testList[index].epreuve);
                                    } else {
                                      Get.snackbar(
                                          'Messae', 'Epreuve non disponible');
                                    }
                                  },
                                  icon:
                                      Icon(Icons.download, color: Colors.blue),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Get.to(
                                      () => ViewTestScreen(
                                        test: testController.testList[index],
                                        id: widget.url,
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.visibility,
                                      color: Colors.blue),
                                ),
                              ],
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
