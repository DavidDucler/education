import 'package:educamer/models/teacher.dart';

abstract class SingleTestTeacherApi {
  Future<List<Teacher>> getAllTeacherByTest();
}
