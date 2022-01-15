import 'package:educamer/models/teachermodel.dart';
import 'package:educamer/services/all_teachers_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class AllTeachersController extends GetxController {
  final AllTeachersService allTeachersService = AllTeachersService();
  List<TeacherModel> allTeachers = [];
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllTeachers();
  }

  Future<void> getAllTeachers() async {
    loading.value = true;
    try {
      allTeachers = await allTeachersService.getAllHomeTeacherByTest();
      loading.value = false;
    } on FirebaseException catch (e) {
      print(e.message);
      loading.value = false;
    }
  }
}
