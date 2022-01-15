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
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((doc) => {
                      listModel.add(
                        TeacherModel.fromMap(
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
    return listModel;
  }
}
