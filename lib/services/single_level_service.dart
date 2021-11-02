import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educamer/api/single_level_api.dart';
import 'package:educamer/models/matiere.dart';

class SingleLevelService extends SingleLevelApi {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<List<Matiere>> getAll({String collectionName}) async {
    List<Matiere> listMatiere = [];
    try {
      await firebaseFirestore
          .collection(collectionName)
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  print(doc.data());
                  listMatiere.add(Matiere.fromMap(doc.data()));
                })
              });
      return listMatiere;
    } on FirebaseException catch (e) {
      print(e.message);
      return listMatiere;
    }
  }
}
