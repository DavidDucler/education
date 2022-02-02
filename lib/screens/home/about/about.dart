import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String message =
      ' est une application permettant aux enseignants et au apprenants de disposer des epreuves des etablissements scolaires du cameroun dans toutes les matieres. De plus elle met propose aux apprenants des repetiteurs a domicile aux differentes matieres proposees dans le systeme educatif (Mathematique,Physique,etc ...) ';
  String msg1 =
      'Soutenir Sujetscam c,est pour:”Toujours plus d\'épreuves à traiter et une une réussite mieux envisageable (le travail mène au succès )”.Alors vous pouvez faire un don soit par';
  String msg2 =
      ' ou simplement envoyez un épreuve récente(Version Pdf) au Numéro (694735363) par Whatsapp ou a l\'adresse mail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'A Propos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Qui Sommes nous?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: RichText(
                text: TextSpan(
                    text: 'Sujetscam',
                    style: GoogleFonts.nunitoSans(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: message,
                        style: TextStyle(
                          color: Color(0xFFC6C6C6),
                          fontSize: 16,
                        ),
                      )
                    ]),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              title: Text(
                'Nous Soutenir',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: RichText(
                text: TextSpan(
                    text: msg1,
                    style: GoogleFonts.nunitoSans(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: ' Orange Money ',
                        style: GoogleFonts.nunitoSans(
                          color: Colors.orange,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: msg2,
                        style: GoogleFonts.nunitoSans(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: ' sujetcam237@gmail.com',
                        style: GoogleFonts.nunitoSans(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            ListTile(
              title: Text(
                'Devenir enseignant a domicile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              subtitle: Text(
                'Contacter l\'administrateur de SujetCam au 694735363 par whatsapp pour les modalites de compte.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
