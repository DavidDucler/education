import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:educamer/models/test.dart';

class Matiere {
  String name;
  String epreuves;
  List<Test> list;
  Matiere({
    @required this.name,
    @required this.epreuves,
    this.list,
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
      // list: List<Test>.from(map['list']?.map((x) => Test.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Matiere.fromJson(String source) =>
      Matiere.fromMap(json.decode(source));

  @override
  String toString() => 'Matiere(name: $name, epreuves: $epreuves, list: $list)';
}
