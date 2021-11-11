import 'package:flutter/material.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({Key key}) : super(key: key);

  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enseignants a domicile'),
      ),
      body: Container(),
    );
  }
}
