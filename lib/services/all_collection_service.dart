import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educamer/api/all_level_api.dart';
import 'package:educamer/models/niveau.dart';

class AllLevelService extends AllLevelApi {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<List<Niveau>> allLevels() async {
    List<Niveau> _listLevel = [];
    try {
      await firebaseFirestore
          .collection('educamer')
          .get()
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((doc) => {
                      _listLevel.add(
                        Niveau.fromMap(
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
    return _listLevel;
  }
}
