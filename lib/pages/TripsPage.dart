import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:lorrystand/widgets/menu.dart';
import 'package:lorrystand/widgets/TripsWidget.dart';
import 'package:lorrystand/config/app_config.dart' as config;

class TripsPage extends StatefulWidget {
  TripsPage({Key key}) : super(key: key);

  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> with TickerProviderStateMixin {
  Color color1 = new Color(0xff212732);
  Color color2 = new Color(0xfffed226);
  Color color3 = new Color(0xfff8941c);

  final pageController = new PageController(initialPage: 0);

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: MenuDrawer(),
      /*appBar: new AppBar(
        title: new Text("Trips"),
        elevation: 0.7,  
      ),*/
      body: Stack(children: <Widget>[
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
          child: Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.box,
                size: config.App(context).appHeight(10),
                color: color2,
              ),
              SizedBox(
                width: config.App(context).appWidth(5),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "TRIPS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                    Text(
                      "confirmed trips from customers",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                height: config.App(context).appHeight(10),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          padding: EdgeInsets.only(
              top: config.App(context).appHeight(10),
              left: config.App(context).appWidth(5)),
        ),
        Padding(
          padding: EdgeInsets.only(top: config.App(context).appHeight(25)),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: config.App(context).appWidth(1.2),
              ),
              tab(pageIndex == 0 ? color3 : color2, "TRIPS", 0),
              SizedBox(
                width: config.App(context).appWidth(1.2),
              ),
              Expanded(
                  child: tab(
                      pageIndex == 1 ? color3 : color2, "ASSIGNED TRIPS", 1)),
              SizedBox(
                width: config.App(context).appWidth(1.2),
              ),
              Expanded(
                  child: tab(
                      pageIndex == 2 ? color3 : color2, "PAYMENT STATUS", 2)),
              SizedBox(
                width: config.App(context).appWidth(1.2),
              ),
              Expanded(
                  child: tab(
                      pageIndex == 3 ? color3 : color2, "DELIVERY STATUS", 3)),
              SizedBox(
                width: config.App(context).appWidth(1.2),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
        Padding(
          child: PageView(
            controller: pageController,
            children: <Widget>[
              //Padding(child:
              TripsWidget("confirmed"), //padding: EdgeInsets.only(top: config.App(context).appHeight(30)),),
              TripsWidget("assigned"),
              TripsWidget("paymentStatus"),
              TripsWidget("deliveryStatus")
            ],
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
          ),
          padding: EdgeInsets.only(top: config.App(context).appHeight(30)),
        )
      ]),
    );
  }

  Widget tab(Color color, String title, int index) {
    return GestureDetector(
      child: Container(
        color: color,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: config.App(context).appWidth(2.5)),
          ),
        ),
        padding: EdgeInsets.all(7),
        height: config.App(context).appHeight(4),
      ),
      onTap: () {
        pageController.jumpToPage(index);
      },
    );
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
        size.height * 0.8, size.width, size.height * 0.75);
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
