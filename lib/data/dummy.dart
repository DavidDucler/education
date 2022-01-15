import 'package:educamer/models/wizard.dart';
import 'package:flutter/material.dart';

class Dummy {
  //Wizard data -----------------------------------------
  static const List<String> wizard_title = [
    "Banques d'épreuves",
    "Enseignants à domicile",
    "Notification"
  ];
  static const List<String> wizard_brief = [
    // "Choose your destination, plan Your trip. Pick the best place for Your holiday",
    "Retrouvez-sur Educamer les épreuves des plus collèges et lycées du cameroun",
    "Vous avez des difficultés,desormais Sur Educamer vous disposez des enseignants qualifiés, faites votre choix",
    "Profitez des notifactions instantanées",
  ];
  static const List<String> wizard_image = [
    // "lottie_property.json",
    "lottie_invoice.json",
    "lottie_analytics.json",
    "lottie_notification.json",
  ];
  static const List<String> wizard_background = [
    // "image_15.jpg",
    "image_10.jpg",
    "image_3.jpg",
    "image_12.jpg"
  ];

  static const List<Color> wizard_color = [
    // Colors.red,
    Colors.green,
    Colors.lightGreen,
    Colors.greenAccent,
  ];

  //
  static List<Wizard> getWizard() {
    List<Wizard> items = [];
    for (int i = 0; i < wizard_title.length; i++) {
      Wizard obj = new Wizard();
      obj.image = wizard_image[i];
      obj.background = wizard_background[i];
      obj.title = wizard_title[i];
      obj.brief = wizard_brief[i];
      obj.color = wizard_color[i];
      items.add(obj);
    }
    return items;
  }
}
