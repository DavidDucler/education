import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TestApi {
  Future<List<QueryDocumentSnapshot>> getInitialTestList();
}
