import 'package:educamer/models/test.dart';
import 'package:educamer/services/test_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  final TestService testService = TestService();
  RxList<Test> testList = <Test>[].obs;
  RxBool loading = false.obs;
  Future<void> getAllTest({String collectionName}) async {
    loading.value = true;
    try {
      testList.value =
          await testService.getAllTest(collectionName: collectionName);
      loading.value = false;
    } on FirebaseException catch (e) {
      print(e.message);
    } finally {
      loading.value = false;
    }
  }
}
