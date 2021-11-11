import 'package:educamer/data/img.dart';
import 'package:educamer/models/niveau.dart';
import 'package:flutter/material.dart';

class BuildNiveau extends StatelessWidget {
  final VoidCallback onTap;
  final Niveau niveau;
  const BuildNiveau({Key key, this.niveau, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Container(
          height: 70,
          width: 70,
          /* foregroundDecoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7), BlendMode.dstOut),
              image: AssetImage(
                Img.get('tableau.jpg'),
              ),
            ),
          ), */
          //margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            /* image:
                DecorationImage(image: AssetImage(Img.get('img_wizard_1.png'))), */
            color: Colors.white,
            /* borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ) ,*/
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.class_,
                size: 64,
                color: Colors.white,
              ),
              Text(
                niveau.name,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: Text(
                  niveau.nbEpreuves,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Text('Epreuves'),
            ],
          ),
        ),
      ),
    );
  }
}
