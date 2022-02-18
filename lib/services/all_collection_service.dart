import 'dart:async';
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
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firebaseFirestore
              .collection('educamer')
              .get()
              .timeout(Duration(seconds: 60));

      querySnapshot.docs.forEach((doc) => {
            _listLevel.add(
              Niveau.fromMap(
                doc.data(),
              ),
            ),
            print(doc.data()),
          });
      return _listLevel;
    } on TimeoutException catch (e) {
      print(e.message);
      throw AllServiceException(
          message:
              'Impossible de charger les classes disponibles,Vérifier votre connection internet et réssayez Svp');
    } catch (e) {
      throw AllServiceException();
    }
  }
}

class AllServiceException implements Exception {
  final String message;
  AllServiceException({
    this.message = 'Une erreur est survenue,Ressayez Svp',
  });
}
