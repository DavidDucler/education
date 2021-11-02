import 'package:flutter/material.dart';

class MyText {
  static TextStyle display1(BuildContext context) {
    return Theme.of(context).textTheme.subtitle1;
  }

  static TextStyle medium(BuildContext context) {
    return Theme.of(context).textTheme.headline6;
  }

  static TextStyle subhead(BuildContext context) {
    return Theme.of(context).textTheme.subtitle1;
  }
}
