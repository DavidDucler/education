import 'package:cached_network_image/cached_network_image.dart';
import 'package:educamer/models/teacher.dart';
import 'package:educamer/widgets/teacher_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherWidget extends StatelessWidget {
  final Teacher teacher;
  const TeacherWidget({
    Key key,
    this.teacher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(5, 5),
              blurRadius: 10,
              spreadRadius: 5,
            )
          ]),
      child: ListTile(
        onTap: () {
          Get.to(
            () => DetailsTeacher(
              teacher: teacher,
            ),
          );
        },
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        leading: Container(
          width: 70,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(teacher.imagePath),
          ),
        ),
        title: Text(
          '(Mr/Mne) ' + teacher.lastName + ' ' + teacher.firstName,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Age: ' + teacher.age + ' ans',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Telephone: ' + teacher.phoneNumber,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 80,
              child: Row(
                children: [
                  Icon(
                    Icons.location_city,
                    color: Colors.pinkAccent,
                    size: 24,
                  ),
                  Text(
                    teacher.city,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Text(
              teacher.domicile,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.visibility,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                onPressed: () {
                  Get.to(
                    () => DetailsTeacher(
                      teacher: teacher,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
