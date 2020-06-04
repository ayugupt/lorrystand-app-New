import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/booking_provider.dart';
import 'package:lorrystand/widgets/menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lorrystand/widgets/EnquiriesWidget.dart';
import 'package:lorrystand/widgets/BidsWidget.dart';
import 'package:lorrystand/widgets/BookingsWidget.dart';
import 'package:lorrystand/config/app_config.dart' as config;

class HomeTransporterPage extends StatefulWidget {
  HomeTransporterPage({Key key}) : super(key: key);

  @override
  _HomeTransporterPageState createState() => _HomeTransporterPageState();
}

class _HomeTransporterPageState extends State<HomeTransporterPage>
    with TickerProviderStateMixin {
  var tab;

  final pageController = new PageController(initialPage: 0);

  int tabNo = 0;

  Color color1 = new Color(0xff212732);
  Color color2 = new Color(0xfffed226);
  Color color3 = new Color(0xfff8941c);

  @override
  void initState() {
    super.initState();
    setState(() {
      tab = "new";
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: MenuDrawer(),
      appBar: new AppBar(
        title: RaisedButton(
          textColor: Colors.black,
          color: color2,
          child: Text(
            "TRANSPORT",
            style: (TextStyle(color: Color(0xFF212838), fontSize: 17)),
          ),
          onPressed: () {},
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
        backgroundColor: color1,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
           Container(
          width: config.App(context).appWidth(100),
          height: config.App(context).appHeight(50),
          child: ClipPath(
              child: Container(
                color: color1,
              ),
              clipper: Design()),
        ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FaIcon(FontAwesomeIcons.book, color: color2, size: 49),
                SizedBox(
                  width: 30,
                ),
                Container(
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'DASHBOARD',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Getting the enquiry from the customers',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  textColor: tabNo == 0 ? Colors.white : Colors.black,
                  color: tabNo == 0 ? color3 : color2,
                  child: Text("New Enquiries"),
                  onPressed: () {
                    pageController.jumpToPage(0);
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                ),
                RaisedButton(
                  textColor: tabNo == 1 ? Colors.white : Colors.black,
                  color: tabNo == 1 ? color3 : color2,
                  child: Text("Ongoing Bids"),
                  onPressed: () {
                    pageController.jumpToPage(1);
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                )
              ],
            ),
          ),
          Padding(
            child: PageView(
              controller: pageController,
              children: <Widget>[EnquiriesWidget(), BidsWidget()],
              onPageChanged: (index) {
                setState(() {
                  tabNo = index;
                });
              },
            ),
            padding: EdgeInsets.only(top: 170.0),
          )
          /*tab == "bids"
              ? Padding(
                  padding: const EdgeInsets.only(top: 170.0),
                  child: BidsWidget(),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 170.0),
                  child: EnquiriesWidget(),
                ),*/
        ],
      ),
    );

    /*Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: MenuDrawer(),
      appBar: new AppBar(
        title: new Text("Lorrystand"),
        elevation: 0.7,
        bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            new Tab(text: "Enquires"),
            new Tab(text: "Bids"),
            new Tab(text: "Bookings"),
          ],
        ),
        actions: <Widget>[
          // new Icon(Icons.search),
          // new Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
          // ),
           IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.filter,
                  size: 16.0,
                ),
                onPressed: () => {},
              ),
        ],
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          EnquiriesWidget(),
          BidsWidget(),
          BookingsWidget()          
        ],
      ),
    );
  }

}*/
  }
}

class Design extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.95);
    /*path.conicTo(
        size.width * 0.05, size.height, size.width, size.height * 0.6, 1);*/
    path.cubicTo(size.width * 0.15, size.height, size.width * 0.5,
        size.height * 0.7, size.width, size.height * 0.65);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(oldDelegate) {
    return false;
  }
}