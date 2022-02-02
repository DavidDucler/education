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
   ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    singleTestTeachersController.getInitialTeachers(
        collectionName: widget.teacherModel.testname);
    scrollController = ScrollController()..addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.offset == scrollController.position.maxScrollExtent) {
      print(scrollController.offset);
      singleTestTeachersController.getNextTeachers(
          collectionName: widget.teacherModel.testname);
    }
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
      body: singleTestTeachersController.obx(
        (state) => RefreshIndicator(
          onRefresh: () => singleTestTeachersController.getInitialTeachers(
              collectionName: widget.teacherModel.testname),
          child: ListView.builder(
            itemCount: singleTestTeachersController.listTeacher.length,
            itemBuilder: (context, index) => TeacherWidget(
              teacher: singleTestTeachersController.listTeacher[index],
            ),
          ),
        ),
          onEmpty: Center(
          child: Text(
            'Oups,Aucune Enseignants disponibles',
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
                onPressed: () =>
                    singleTestTeachersController.getInitialTeachers(
                        collectionName: widget.teacherModel.testname),
                icon: Icon(
                  Icons.replay_outlined,
                  color: Color(0xFF4ACF70),
                  size: 48,
                ),
              ),
            ],
          ),
        ),
        onLoading: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
