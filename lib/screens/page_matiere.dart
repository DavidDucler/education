import 'package:educamer/controllers/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                                  onPressed: () {},
                                  icon:
                                      Icon(Icons.download, color: Colors.blue),
                                ),
                                IconButton(
                                  onPressed: () {},
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
