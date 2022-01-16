import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:educamer/api/test_api.dart';

class TestService extends TestApi {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<List<QueryDocumentSnapshot>> getInitialTestList(
      {String collectionName,
      int numberToLoadAtTime,
      QueryDocumentSnapshot lastFetchDocument}) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection(collectionName)
          .limit(numberToLoadAtTime)
          .get()
          .timeout(
            Duration(seconds: 1),
          );

      /* .then((querySnapshot) => {
                querySnapshot.docs.forEach((doc) => {
                      listTest.add(
                        Test.fromMap(
                          doc.data(),
                        ),
                      ),
                      print(doc.data()),
                    }),
              }); */
      return querySnapshot.docs;
    } on TimeoutException catch (e) {
      print(e.message);
      throw TestException(
          message:
              'Impossible de charger les epreuves,Verifier votre connection internet et Ressayez.');
    } catch (e) {
      print(e.toString());
      throw TestException(
          message:
              'Une erreur est survenue,Verifier votre connection internet ou Ressayez plus tard.');
    }
  }

  Future<List<QueryDocumentSnapshot>> getNextTestList(
      {String collectionName,
      int numberToLoadAtTime,
      QueryDocumentSnapshot lastFetchDocument}) async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection(collectionName)
          .startAfterDocument(lastFetchDocument)
          .limit(numberToLoadAtTime)
          .get();
      return querySnapshot.docs;
    } on SocketException catch (e) {
      print('pas de connection internet');
      print(e.message);
      throw TestException(message: 'Verifier votre connection internet');
    } catch (e) {
      print('pas de connection internet');
      print(e.message);
      throw TestException(message: e.toString());
    }
  }
}

class TestException implements Exception {
  final String message;
  TestException({
    this.message = 'Une erreur est survenue',
  });
}
