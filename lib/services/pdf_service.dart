import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:educamer/models/test.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PdfService {
  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  static Future<String> getPdfDownloadUrl(String epreuve,
      {String pdfPath}) async {
    try {
      ListResult list = await firebaseStorage.ref().listAll();
      list.items.forEach((element) {
        print(element.getDownloadURL());
      });
      String url = await firebaseStorage.ref(pdfPath).getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      print(e.code);
      print(e.message);
      return null;
    }
  }

  static Future<void> downloadTest({Test test}) async {
    Uint8List testData = await firebaseStorage.ref(test.epreuve).getData();
    _storeFile(test, testData);
  }

  static Future<File> _storeFile(Test test, List<int> bytes) async {
    final filename = basename(test.schoolname);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
