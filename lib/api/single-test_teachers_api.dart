import 'package:cloud_firestore/cloud_firestore.dart';


abstract class SingleTestTeacherApi {
  Future<List<QueryDocumentSnapshot>> getAllTeacherByTest();
}
