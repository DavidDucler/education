import 'dart:convert';

class Teacher {
  String firstName;
  String lastName;
  int gender;
  String phoneNumber;
  String email;
  String age;
  String about;
  String city;
  List<String> quaters;
  String imagePath;
  String experienceYear;
  String profession;
  String firstCyclePrice;
  String secondCyclePrice;
  String domicile;
  List<String> lang;
  Teacher({
    this.firstName,
    this.lastName,
    this.gender,
    this.phoneNumber,
    this.email,
    this.age,
    this.about,
    this.city,
    this.quaters,
    this.imagePath,
    this.experienceYear,
    this.profession,
    this.firstCyclePrice,
    this.secondCyclePrice,
    this.domicile,
    this.lang,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'age': age,
      'about': about,
      'city': city,
      'quaters': quaters,
      'imagePath': imagePath,
      'experienceYear': experienceYear,
      'profession': profession,
      'firstCyclePrice': firstCyclePrice,
      'secondCyclePrice': secondCyclePrice,
      'domicile': domicile,
      'lang': lang,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      firstName: map['firstName'],
      lastName: map['lastName'],
      gender: map['gender'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      age: map['age'],
      about: map['about'],
      city: map['city'],
      //quaters: List<String>.from(map['quaters']),
      imagePath: map['imagePath'],
      experienceYear: map['experienceYear'],
      profession: map['profession'],
      firstCyclePrice: map['firstCyclePrice'],
      secondCyclePrice: map['secondCyclePrice'],
      domicile: map['domicile'],
      lang: List<String>.from(map['lang']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) =>
      Teacher.fromMap(json.decode(source));
}
