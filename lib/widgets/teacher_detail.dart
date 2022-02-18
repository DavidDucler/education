import 'package:cached_network_image/cached_network_image.dart';
import 'package:educamer/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsTeacher extends StatefulWidget {
  final Teacher teacher;
  const DetailsTeacher({
    Key key,
    this.teacher,
  }) : super(key: key);

  @override
  _DetailsTeacherState createState() => _DetailsTeacherState();
}

class _DetailsTeacherState extends State<DetailsTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            snap: true,
            floating: true,
            expandedHeight: 300,
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              IconButton(
                onPressed: () async {
                  String url =
                      "https://wa.me/+237${widget.teacher.phoneNumber}/?text=Bonjour Mr/Mdne";
                  launch(url);
                },
                icon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: RichText(
                text: TextSpan(
                  text: widget.teacher.gender == 0 ? 'Mne ' : 'Mr ',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: widget.teacher.lastName +
                          ' ' +
                          widget.teacher.firstName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              background: CachedNetworkImage(
                imageUrl: widget.teacher.imagePath,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(.1),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: Colors.white,
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.symmetric(horizontal: 10),
                    initiallyExpanded: true,
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFFCBCBCB),
                      child: Icon(
                        Icons.info,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    title: Text(
                      'A propos',
                      style: GoogleFonts.nunitoSans(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Text(
                              'Telephone',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () async {
                                String url =
                                    "https://wa.me/+237${widget.teacher.phoneNumber}/?text=Bonjour Mr/Mdne";
                                launch(url);
                              },
                              icon: Icon(
                                FontAwesomeIcons.whatsapp,
                                color: Theme.of(context).primaryColor,
                                size: 32,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () async {
                                String url =
                                    'tel:+237${widget.teacher.phoneNumber}';
                                await launch(url);
                              },
                              icon: Icon(
                                Icons.phone,
                                color: Theme.of(context).primaryColor,
                                size: 32,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () async {
                                String url =
                                    'sms:+237${widget.teacher.phoneNumber}';
                                await launch(url);
                              },
                              icon: Icon(
                                Icons.sms,
                                color: Theme.of(context).primaryColor,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          widget.teacher.phoneNumber,
                          style: GoogleFonts.nunitoSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Description',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          widget.teacher.about,
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Années d\'experiences',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          widget.teacher.experienceYear + 'ans ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Adresse-email',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          widget.teacher.email,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              String url =
                                  'mailto:${widget.teacher.email}?subject=Cour a domicile';
                              await launch(url);
                            },
                            icon: Icon(
                              Icons.email,
                              size: 32,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                      ListTile(
                        title: Text(
                          'Ville & Residence',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              widget.teacher.city,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.teacher.domicile,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFCBCBCB),
                    child: Icon(
                      Icons.language,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  title: Text(
                    'Langues',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Row(
                    children: List.generate(
                      widget.teacher.lang.length,
                      (index) => Text(
                        widget.teacher.lang[index] + ' ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tarification',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Premier cycle',
                            style: GoogleFonts.nunitoSans(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.teacher.firstCyclePrice + ' fcfa/heure',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Second Cycle',
                            style: GoogleFonts.nunitoSans(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.teacher.secondCyclePrice + ' fcfa/heure',
                            style: GoogleFonts.nunitoSans(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildAvis() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 50),
      title: Row(
        children: [
          Text('Roual@gmail.com'),
          /* RatingBar.builder(
            itemSize: 15,
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ), */
        ],
      ),
      subtitle: Text('je le conseille vivement'),
    );
  }
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;

  CustomSliverDelegate({
    this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;

    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        children: [
          SizedBox(
            height: appBarSize < expandedHeight / 3
                ? expandedHeight / 3
                : appBarSize,
            child: AppBar(
              title: Opacity(
                opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
                child: Text('data'),
              ),
              flexibleSpace: Stack(
                children: [
                  FlexibleSpaceBar(
                    title: Text(
                      'Mne Fotso Viviane',
                    ),
                    background: Image(
                      image: AssetImage('assets/images/teacher-2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom: 0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30 * percent,
                ),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.phone,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => expandedHeight / 3;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
