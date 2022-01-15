import 'package:educamer/models/teacher.dart';
import 'package:educamer/services/signle_test_teachers_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class SingleTestTeachersController extends GetxController {
  final SingleTestTeacherService singleTestTeacherService =
      SingleTestTeacherService();

  RxBool loading = false.obs;
  List<Teacher> listTeacher = [];
  Future<void> getAllTeachers({String collectionName}) async {
    loading.value = true;
    try {
      listTeacher = await singleTestTeacherService.getAllTeacherByTest(
          collectionName: collectionName);
      loading.value = false;
    } on FirebaseException catch (e) {
      print(e.message);
      loading.value = false;
    }
  }
}
