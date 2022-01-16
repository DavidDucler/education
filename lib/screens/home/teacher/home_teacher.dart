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
      body: allTeachersController.obx(
        (state) => RefreshIndicator(
          onRefresh: () => allTeachersController.getAllTeachers(),
          child: GridView.builder(
            itemCount: state.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context, index) => BuildTeacher(
              teacher: state[index],
              onTap: () {
                Get.to(
                  () => SingleTestTeacherPage(
                      teacherModel: state[index],
                  ),
                );
              },
            ),
          ),
        ),
          onLoading: Center(
          child: CircularProgressIndicator(),
        ),
        onEmpty: Center(
          child: Text(
            'Oups,Aucun enseignants',
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
                onPressed: () => allTeachersController.getAllTeachers(),
                icon: Icon(
                  Icons.replay_outlined,
                  color: Color(0xFF4ACF70),
                  size: 48,
                ),
              ),
            ],
          ),
        ),
      ),
        
    );
  }
}
