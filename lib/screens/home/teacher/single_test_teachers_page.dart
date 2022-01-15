import 'package:educamer/controllers/single-test_teachers_controller.dart';
import 'package:educamer/models/teachermodel.dart';
import 'package:educamer/widgets/teacher_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleTestTeacherPage extends StatefulWidget {
  final TeacherModel teacherModel;
  const SingleTestTeacherPage({
    Key key,
    this.teacherModel,
  }) : super(key: key);

  @override
  _SingleTestTeacherPageState createState() => _SingleTestTeacherPageState();
}

class _SingleTestTeacherPageState extends State<SingleTestTeacherPage> {
  final SingleTestTeachersController singleTestTeachersController =
      Get.put(SingleTestTeachersController());
  @override
  void initState() {
    super.initState();
    singleTestTeachersController.getAllTeachers(
        collectionName: widget.teacherModel.testname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Nos Enseignants de ' + widget.teacherModel.testname,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: Obx(
        () => singleTestTeachersController.loading.isTrue
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => singleTestTeachersController.getAllTeachers(
                    collectionName: widget.teacherModel.testname),
                child: ListView.builder(
                  itemCount: singleTestTeachersController.listTeacher.length,
                  itemBuilder: (context, index) => TeacherWidget(
                    teacher: singleTestTeachersController.listTeacher[index],
                  ),
                ),
              ),
      ),
    );
  }
}
