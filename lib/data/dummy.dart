import 'package:educamer/models/wizard.dart';
import 'package:flutter/material.dart';

class Dummy {
  //Wizard data -----------------------------------------
  static const List<String> wizard_title = [
    "Ready to Travel",
    "Pick the Ticket",
    "Flight to Destination",
    "Enjoy Holiday"
  ];
  static const List<String> wizard_brief = [
    "Choose your destination, plan Your trip. Pick the best place for Your holiday",
    "Select the day, pick Your ticket. We give you the best prices. We guarantee!",
    "Safe and Comfort flight is our priority. Professional crew and services.",
    "Enjoy your holiday, Don't forget to feel the moment and take a photo!",
  ];
  static const List<String> wizard_image = [
    "img_wizard_1.png",
    "img_wizard_2.png",
    "img_wizard_3.png",
    "img_wizard_4.png",
  ];
  static const List<String> wizard_background = [
    "image_15.jpg",
    "image_10.jpg",
    "image_3.jpg",
    "image_12.jpg"
  ];
  static const List<Color> wizard_color = [
    Colors.red,
    Colors.blueGrey,
    Colors.purple,
    Colors.orange,
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
