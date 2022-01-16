import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educamer/models/teacher.dart';
import 'package:educamer/services/signle_test_teachers_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class SingleTestTeachersController extends GetxController
    with StateMixin<List<Teacher>> {
  final SingleTestTeacherService singleTestTeacherService =
      SingleTestTeacherService();

  RxBool loading = false.obs;
  RxList<Teacher> listTeacher = <Teacher>[].obs;
  QueryDocumentSnapshot lastFetchDocument;
  List<QueryDocumentSnapshot> initialList;
  List<QueryDocumentSnapshot> newFetchedList;
  RxInt numberToloadAtTime = 10.obs;

  Future<void> getInitialTeachers({String collectionName}) async {
    change(null, status: RxStatus.loading());
    try {
      initialList = [];
      listTeacher.value = [];
      initialList = await singleTestTeacherService.getAllTeacherByTest(
          collectionName: collectionName,
          numberToLoadAtTime: numberToloadAtTime.value);
      initialList.forEach((element) {
        listTeacher.add(Teacher.fromMap(element.data()));
      });
      if (listTeacher.length == 0) {
        change(null, status: RxStatus.empty());
      } else {
        change(listTeacher, status: RxStatus.success());
        lastFetchDocument = initialList[initialList.length - 1];
        print(initialList.length - 1);
      }
    } on TeacherException catch (e) {
      change(null, status: RxStatus.error(e.message));
    }
  }

  Future<void> getNextTeachers({String collectionName}) async {
    try {
      List<Teacher> nextTeachers = [];
      newFetchedList = await singleTestTeacherService.getNextTeacherByTest(
          collectionName: collectionName,
          numberToLoadAtTime: numberToloadAtTime.value,
          lastFetchDocument: lastFetchDocument);
      newFetchedList.forEach((element) {
        nextTeachers.add(Teacher.fromMap(element.data()));
      });
      listTeacher.addAll(nextTeachers);
      if (newFetchedList.length == 0) {
        print('no More');
      } else {
        lastFetchDocument = newFetchedList[newFetchedList.length - 1];
        change(listTeacher, status: RxStatus.loadingMore());
      }
    } on TeacherException catch (e) {
      Get.showSnackbar(
        GetBar(
          title: 'MESSAGE',
          message: e.message,
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}
