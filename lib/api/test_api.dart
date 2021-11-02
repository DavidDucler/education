import 'package:educamer/models/test.dart';

abstract class TestApi {
  Future<List<Test>> getAllTest();
}
