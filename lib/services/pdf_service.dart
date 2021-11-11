import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class PdfService {
  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  static Future<File> loadFirebaseFile({String url}) async {
    final refPdf = firebaseStorage.ref(url);
    final bytes = await refPdf.getDownloadURL();
  }
}
