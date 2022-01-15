import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educamer/api/single-test_teachers_api.dart';
import 'package:educamer/models/teacher.dart';
import 'package:firebase_core/firebase_core.dart';

class SingleTestTeacherService extends SingleTestTeacherApi {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<List<Teacher>> getAllTeacherByTest({String collectionName}) async {
    List<Teacher> listTeacher = [];
    try {
      await firebaseFirestore
          .collection('Teachers-' + collectionName)
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((doc) => {
                      listTeacher.add(
                        Teacher.fromMap(
                          doc.data(),
                        ),
                      ),
                      print(doc.data()),
                    }),
              });
      // print(_listLevel.toString());
    } on FirebaseException catch (e) {
      print(e.message);
    }

    return listTeacher;
  }
}
