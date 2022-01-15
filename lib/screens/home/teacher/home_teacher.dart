import 'package:educamer/controllers/all_teachers_controller.dart';
import 'package:educamer/screens/home/teacher/single_test_teachers_page.dart';
import 'package:educamer/widgets/build_teacher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({Key key}) : super(key: key);

  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  final AllTeachersController allTeachersController =
      Get.put(AllTeachersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enseignants à domicile'),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Obx(
        () => allTeachersController.loading.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => allTeachersController.getAllTeachers(),
                child: GridView.builder(
                  itemCount: allTeachersController.allTeachers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) => BuildTeacher(
                    teacher: allTeachersController.allTeachers[index],
                    onTap: () {
                      Get.to(
                        () => SingleTestTeacherPage(
                          teacherModel:
                              allTeachersController.allTeachers[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
