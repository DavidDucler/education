import 'package:educamer/screens/home/accueil/home_screen.dart';
import 'package:educamer/screens/home/teacher/home_teacher.dart';
import 'package:flutter/material.dart';

import 'about/about.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  final List<BottomNavigationBarItem> bottomList = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Accueil'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('Teachers'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.info_rounded),
      title: Text('A Propos'),
    ),
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> homeList = [
    HomeScreen(),
    TeacherHome(),
    AboutPage(),
  ];
  int currentIndex = 0;
  bool mySession = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: homeList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[400],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: widget.bottomList,
      ),
    );
  }
}
