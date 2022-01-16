import 'package:educamer/models/teachermodel.dart';


abstract class AllTeacherApi {
  Future<List<TeacherModel>> getAllHomeTeacherByTest();
}
