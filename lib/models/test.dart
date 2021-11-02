import 'dart:convert';

import 'package:flutter/foundation.dart';

class Test {
  String sequence;
  String epreuve;
  String corrige;
  String schoolname;
  String annee;
  Test({
    @required this.sequence,
    @required this.epreuve,
    @required this.corrige,
    @required this.schoolname,
    this.annee,
  });

  Map<String, dynamic> toMap() {
    return {
      'sequence': sequence,
      'epreuve': epreuve,
      'corrige': corrige,
      'schoolname': schoolname,
    };
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      sequence: map['sequence'],
      epreuve: map['epreuve'],
      corrige: map['corrige'],
      schoolname: map['schoolname'],
      annee: map['annee'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Test.fromJson(String source) => Test.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Test(sequence: $sequence, epreuve: $epreuve, corrige: $corrige, schoolname: $schoolname)';
  }
}
