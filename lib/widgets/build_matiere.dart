import 'package:educamer/models/matiere.dart';
import 'package:flutter/material.dart';

class BuildMatiere extends StatelessWidget {
  final VoidCallback onTap;
  final Matiere matiere;
  const BuildMatiere({Key key, this.matiere, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: Colors.transparent,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              offset: Offset(0, 5),
              blurRadius: 14,
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              matiere.name,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            CustomPaint(
              painter: MyTextPainter(),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              child: Text(
                matiere.epreuves,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              ' Epreuves',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(MyTextPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(MyTextPainter oldDelegate) => false;
}
