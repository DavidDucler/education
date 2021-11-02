import 'dart:convert';

import 'package:flutter/foundation.dart';

class Niveau {
  String name;
  String nbEpreuves;
  Niveau({
    @required this.name,
    @required this.nbEpreuves,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nbEpreuves': nbEpreuves,
    };
  }

  factory Niveau.fromMap(Map<String, dynamic> map) {
    return Niveau(
      name: map['nom'],
      nbEpreuves: map['epreuves'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Niveau.fromJson(String source) => Niveau.fromMap(json.decode(source));

  @override
  String toString() => 'Niveau(name: $name, nbEpreuves: $nbEpreuves)';
}
