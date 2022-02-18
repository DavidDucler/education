import 'dart:async';

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
          .timeout(Duration(seconds: 60))
          .then((querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  print(doc.data());
                  listMatiere.add(Matiere.fromMap(doc.data()));
                })
              });
      return listMatiere;
    } on TimeoutException catch (e) {
      throw SingleLevelException(
          message:
              'Impossible de charger les classes disponibles,Vérifier votre connection internet et réssayez Svp');
    } catch (e) {
      throw SingleLevelException();
    }
  }
}

class SingleLevelException implements Exception {
  final String message;
  SingleLevelException({
    this.message = 'Une erreur est survenue,Ressayez Svp',
  });
}
