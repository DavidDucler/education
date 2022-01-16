import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:educamer/api/all_teacher_api.dart';
import 'package:educamer/models/teachermodel.dart';

class AllTeachersService extends AllTeacherApi {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  @override
  Future<List<TeacherModel>> getAllHomeTeacherByTest() async {
    List<TeacherModel> listModel = [];
    try {
       await firebaseFirestore
          .collection('Teachers')
          .get()
          .timeout(Duration(minutes: 1))
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) => {
              listModel.add(
                TeacherModel.fromMap(
                  doc.data(),
                ),
              ),
              print(doc.data())
            });
          });
    } on TimeoutException catch (_) {
      throw TeacherModelException(
          message: 'Verifier votre connection internet');
    } catch (e) {
      throw TeacherModelException(
          message:
              'Une erreur est survenue,Verifier votre connection internet ou Ressayez plus tard.');
    }
     return listModel;
  }
}

class TeacherModelException implements Exception {
  final String message;
  TeacherModelException({
    this.message = 'Une errer est survenue',
  });
}
