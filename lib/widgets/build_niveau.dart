import 'package:educamer/models/niveau.dart';
import 'package:flutter/material.dart';

class BuildNiveau extends StatelessWidget {
  final VoidCallback onTap;
  final Niveau niveau;
  const BuildNiveau({Key key, this.niveau, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 70,
          width: 70,
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.9),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                niveau.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(niveau.nbEpreuves + ' Epreuves'),
            ],
          ),
        ),
      ),
    );
  }
}
