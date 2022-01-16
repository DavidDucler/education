
import 'package:educamer/models/teachermodel.dart';
import 'package:educamer/services/all_teachers_service.dart';

import 'package:get/get.dart';

class AllTeachersController extends GetxController
    with StateMixin<List<TeacherModel>> {
  final AllTeachersService allTeachersService = AllTeachersService();
 
  List<TeacherModel> allTeacher = [];
  
  
  @override
  void onInit() {
    super.onInit();
    getAllTeachers();
  }

  Future<void> getAllTeachers() async {
    change(null, status: RxStatus.loading());
    try {
      allTeacher = await allTeachersService.getAllHomeTeacherByTest();
      if (allTeacher.length == 0) {
        change(null, status: RxStatus.empty());
      } else {
        change(allTeacher, status: RxStatus.success());
      }
    } on TeacherModelException catch (e) {
      change(null, status: RxStatus.error(e.message));
    }
  }
}
