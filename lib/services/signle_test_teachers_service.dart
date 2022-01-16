import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:educamer/api/single-test_teachers_api.dart';


class SingleTestTeacherService extends SingleTestTeacherApi {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<List<QueryDocumentSnapshot>> getAllTeacherByTest({
    String collectionName,
    int numberToLoadAtTime,
  }) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection('Teachers-' + collectionName)
          .limit(numberToLoadAtTime)
          .get()
          .timeout(Duration(minutes: 1));
      return querySnapshot.docs;
    } on TimeoutException catch (_) {
      throw TeacherException(
          message:
              'Impossible de charger la liste des enseignants,Verifier votre connection internet et Ressayez.');
    } catch (_) {
      throw TeacherException(
          message:
              'Une erreur est survenue,Verifier votre connection internet ou Ressayez plus tard.');
    }
  }

  Future<List<QueryDocumentSnapshot>> getNextTeacherByTest(
      {String collectionName,
      int numberToLoadAtTime,
      QueryDocumentSnapshot lastFetchDocument}) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection('Teachers-' + collectionName)
          .startAfterDocument(lastFetchDocument)
          .limit(numberToLoadAtTime)
          .get()
          .timeout(Duration(minutes: 1));
      return querySnapshot.docs;
    } on TimeoutException catch (_) {
      throw TeacherException(
          message:
              'Impossible de charger la liste suite,Verifier votre connection internet et Ressayez.');
    } catch (_) {
      throw TeacherException(
          message:
              'Une erreur est survenue,Verifier votre connection internet ou Ressayez plus tard.');
    }
  }
}

class TeacherException implements Exception {
  final String message;
  TeacherException({
    this.message = 'Une erreur est survenue',
  });
}
