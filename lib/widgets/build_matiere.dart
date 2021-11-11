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
      child: Card(
        child: Container(
          height: 70,
          width: 70,
          foregroundDecoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1), BlendMode.dstATop),
              image: NetworkImage(matiere.image),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                matiere.name,
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
                  matiere.epreuves,
                  style: TextStyle(color: Colors.white),
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
      ),
    );
  }
}
