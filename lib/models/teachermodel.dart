import 'dart:convert';

class TeacherModel {
  String testname;
  String teacherNumber;
  TeacherModel({
    this.testname,
    this.teacherNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'testname': testname,
      'teacherNumber': teacherNumber,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      testname: map['testname'],
      teacherNumber: map['teacherNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherModel.fromJson(String source) =>
      TeacherModel.fromMap(json.decode(source));
}
