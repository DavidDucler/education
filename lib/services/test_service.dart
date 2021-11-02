import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educamer/api/test_api.dart';
import 'package:educamer/models/test.dart';

class TestService extends TestApi {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<List<Test>> getAllTest({String collectionName}) async {
    List<Test> listTest = [];
    try {
      await firebaseFirestore
          .collection(collectionName)
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((doc) => {
                      listTest.add(
                        Test.fromMap(
                          doc.data(),
                        ),
                      ),
                      print(doc.data()),
                    }),
              });
      return listTest;
      // print(_listLevel.toString());
    } on FirebaseException catch (e) {
      print(e.message);
      return listTest;
    }
  }
}
