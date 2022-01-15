import 'package:educamer/models/teacher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Mr/Mne  ' +
                    widget.teacher.lastName +
                    ' ' +
                    widget.teacher.firstName +
                    ' (' +
                    widget.teacher.age +
                    ' ans)',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              background: Image(
                image: NetworkImage(widget.teacher.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          /*  SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: CustomSliverDelegate(
              expandedHeight: 300,
            ),
          ), */
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Card(
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  elevation: 1.0,
                  child: Container(
                    color: Colors.white,
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.symmetric(horizontal: 50),
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFFCBCBCB),
                        child: Icon(
                          Icons.info,
                        ),
                      ),
                      title: Text(
                        'A propos',
                        style: GoogleFonts.nunitoSans(),
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            'Telephone',
                            style: GoogleFonts.nunitoSans(),
                          ),
                          subtitle: Text(
                            widget.teacher.phoneNumber,
                            style: GoogleFonts.nunitoSans(),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Description',
                            style: GoogleFonts.nunitoSans(),
                          ),
                          subtitle: Text(
                            widget.teacher.about,
                            style: GoogleFonts.nunitoSans(),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Années d\'experiences',
                            style: GoogleFonts.nunitoSans(),
                          ),
                          subtitle: Text(
                            widget.teacher.experienceYear + 'ans ',
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Adresse-email',
                          ),
                          subtitle: Text(
                            widget.teacher.email,
                          ),
                        ),
                        ListTile(
                          title: Text('Ville & Residence'),
                          subtitle: Row(
                            children: [
                              Text(widget.teacher.city),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(widget.teacher.domicile),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                  elevation: 1.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFFCBCBCB),
                      child: Icon(
                        Icons.language,
                      ),
                    ),
                    title: Text(
                      'Langues',
                      style: GoogleFonts.nunitoSans(),
                    ),
                    subtitle: Row(
                      children: List.generate(
                        widget.teacher.lang.length,
                        (index) => Text(widget.teacher.lang[index] + ' '),
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  elevation: 1.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tarification',
                              style: GoogleFonts.nunitoSans(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Premier cycle',
                                      style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.teacher.firstCyclePrice +
                                          ' fcfa/heure',
                                      style: GoogleFonts.nunitoSans(),
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
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.teacher.secondCyclePrice +
                                          ' fcfa/heure',
                                      style: GoogleFonts.nunitoSans(),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
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
