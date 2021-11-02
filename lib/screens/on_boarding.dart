import 'package:educamer/data/dummy.dart';
import 'package:educamer/data/img.dart';
import 'package:educamer/data/my_colors.dart';
import 'package:educamer/data/my_text.dart';
import 'package:educamer/models/wizard.dart';
import 'package:educamer/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnbaordingScreen extends StatefulWidget {
  const OnbaordingScreen({Key key}) : super(key: key);

  @override
  _OnbaordingScreenState createState() => _OnbaordingScreenState();
}

class _OnbaordingScreenState extends State<OnbaordingScreen> {
  PageController pageController = PageController(initialPage: 0);
  int page = 0;
  bool isLast = false;
  List<Wizard> wizardData = Dummy.getWizard();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          color: Colors.grey[100],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  PageView(
                    onPageChanged: onPageViewChange,
                    controller: pageController,
                    children: buildPageViewItem(),
                  ),
                  Row(
                    children: <Widget>[
                      Spacer(),
                      TextButton(
                        onPressed: () => Get.offAll(() => HomePage()),
                        child: Text('passer'.toUpperCase()),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 60,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: buildDots(context),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                child: Text(
                  isLast ? "Continuer" : "Suivant",
                  style: MyText.subhead(context).copyWith(
                      color: MyColors.grey_90, fontWeight: FontWeight.bold),
                ),
                color: MyColors.grey_10,
                onPressed: () {
                  if (isLast) {
                    Get.offAll(() => HomePage());
                    return;
                  }
                  pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void onPageViewChange(int _page) {
    page = _page;
    isLast = _page == wizardData.length - 1;
    setState(() {});
  }

  List<Widget> buildPageViewItem() {
    List<Widget> widgets = [];
    for (Wizard wz in wizardData) {
      Widget wg = Container(
        padding: EdgeInsets.all(35),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: Wrap(
          children: <Widget>[
            Container(
                width: 280,
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(35),
                          child: Image.asset(Img.get(wz.image),
                              width: 150, height: 150),
                        ),
                        Text(
                          wz.title,
                          style: MyText.medium(context).copyWith(
                              color: MyColors.grey_80,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: Text(
                            wz.brief,
                            textAlign: TextAlign.center,
                            style: MyText.subhead(context)
                                .copyWith(color: MyColors.grey_60),
                          ),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      );
      widgets.add(wg);
    }
    return widgets;
  }

  Widget buildDots(BuildContext context) {
    Widget widget;

    List<Widget> dots = [];
    for (int i = 0; i < wizardData.length; i++) {
      Widget w = Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: 8,
        width: 8,
        child: CircleAvatar(
          backgroundColor: page == i ? Colors.orange[400] : MyColors.grey_20,
        ),
      );
      dots.add(w);
    }
    widget = Row(
      mainAxisSize: MainAxisSize.min,
      children: dots,
    );
    return widget;
  }
}
