import 'package:educamer/models/teachermodel.dart';
import 'package:flutter/material.dart';

class BuildTeacher extends StatelessWidget {
  final VoidCallback onTap;
  final TeacherModel teacher;
  const BuildTeacher({Key key, this.teacher, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                teacher.testname,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: Text(
                  teacher.teacherNumber,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                'Enseignants',
                style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
