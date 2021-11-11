import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:educamer/models/test.dart';

class Matiere {
  String name;
  String epreuves;
  String image;
  List<Test> list;
  Matiere({
    @required this.name,
    @required this.epreuves,
    this.list,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'epreuves': epreuves,
      'list': list?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Matiere.fromMap(Map<String, dynamic> map) {
    return Matiere(
        name: map['nom'],
        epreuves: map['epreuves'],
        image: map['image'] ??
            'https://firebasestorage.googleapis.com/v0/b/educamer-17988.appspot.com/o/images%2Fchemistry-2938901_1920.jpg?alt=media&token=1e198c41-0f8d-4077-876b-7b45c7dffd48'
        // list: List<Test>.from(map['list']?.map((x) => Test.fromMap(x))),
        );
  }

  String toJson() => json.encode(toMap());

  factory Matiere.fromJson(String source) =>
      Matiere.fromMap(json.decode(source));

  @override
  String toString() => 'Matiere(name: $name, epreuves: $epreuves, list: $list)';
}
