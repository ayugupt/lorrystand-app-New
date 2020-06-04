import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lorrystand/pages/transporter/CreateTransportPage.dart';
import 'package:lorrystand/pages/driver/CreateTruckPage.dart';

import 'BookingsWidget.dart';
import 'BookingsWidgetCustomer.dart';
import 'EnquiriesWidget.dart';
import 'EnquiriesWidgetCustomer.dart';
import 'package:lorrystand/widgets/HomeTransporter.dart';

class MenuDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuDrawer();
  }
}

class _MenuDrawer extends State<MenuDrawer> {
  String profile = "";

  Color color1 = new Color(0xff212732);
  Color color2 = new Color(0xfffed226);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(top: 0.0),
        children: <Widget>[
          new ClipPath(
            child: UserAccountsDrawerHeader(
              currentAccountPicture: profile != ""
                  ? new Container(
                      width: 90.0,
                      height: 90.0,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        image: DecorationImage(
                          image: NetworkImage("dfsfsdfs"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: new CircleAvatar(
                          backgroundColor: Colors.white,
                          child: new Text(userProvider.fullName[0])),
                    ),
              decoration: BoxDecoration(
                color: color1,
              ),
              accountName: Padding(
                child: Text("${userProvider.fullName}",
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: color2,
                      fontWeight: FontWeight.w600,
                    )),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.03),
              ),
              accountEmail: SizedBox(),
              /*accountEmail: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${userProvider.email}",
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: color2,
                          fontWeight: FontWeight.w600,
                        )),
                    Text("${userProvider.mobile}",
                        style: new TextStyle(
                          fontSize: 14.0,
                          color: color2,
                          fontWeight: FontWeight.w600,
                        ))
                  ])*/
            ),
            clipper: Design(),
          ),
          Padding(
              child: Text(
                userProvider.userRole == "transporter"
                    ? "Transporter"
                    : userProvider.userRole == "driver" ? "Driver" : "Customer",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
              )),
          ListTile(
              leading: new Icon(FontAwesomeIcons.home),
              title: new Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/home");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfilePage()),
                // );
              }),
          userProvider.userRole == "transporter"
              ? ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text("Dashboard"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeTransporterPage();
                    }));
                  },
                )
              : SizedBox(),
          ListTile(
              leading: new Icon(Icons.location_on),
              title: new Text('Trips'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/Trips");
              }),
          userProvider.user['truck'] == null &&
                  userProvider.userRole == 'driver'
              ? ListTile(
                  leading: new Icon(FontAwesomeIcons.plus),
                  title: new Text('Create Truck'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateTruckPage()),
                    );
                  })
              : SizedBox(),
          userProvider.userRole == 'customer'
              ? ListTile(
                  leading: new Icon(FontAwesomeIcons.firstOrderAlt),
                  title: new Text('Enquiries'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EnquiriesWidgetCustomer(),
                      ),
                    );
                  })
              : SizedBox(),
          userProvider.userRole == 'customer'
              ? ListTile(
                  leading: new Icon(FontAwesomeIcons.book),
                  title: new Text('Bookings'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingsWidgetCustomer(),
                      ),
                    );
                  })
              : SizedBox(),
          userProvider.userRole == 'transporter'
              ? ListTile(
                  leading: new Icon(FontAwesomeIcons.plus),
                  title: new Text('Create Transport'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateTransportPage()),
                    );
                  })
              : SizedBox(),
          userProvider.userRole == 'transporter'
              ? ListTile(
                  leading: new Icon(FontAwesomeIcons.industry),
                  title: new Text('Transport'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/Transport");
                  })
              : SizedBox(),
          userProvider.userRole == 'transporter'
              ? ListTile(
                  leading: new Icon(FontAwesomeIcons.truckMoving),
                  title: new Text('Trucks'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/Trucks");
                  })
              : SizedBox(),
          userProvider.userRole == 'driver'
              ? ListTile(
                  leading: new Icon(FontAwesomeIcons.truckPickup),
                  title: new Text('Truck'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/Driver/Truck",
                        arguments: userProvider.user['truck']['id']);
                  })
              : SizedBox(),
          ListTile(
            leading: Icon(Icons.history),
            title: Text("History"),
          ),
          ListTile(
            leading: new Icon(Icons.person),
            title: new Text('Profile'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed("/Profile");
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          ListTile(
              leading: new Icon(Icons.power_settings_new),
              title: new Text('Logout'),
              onTap: () async {
                Navigator.of(context).pop();
                await userProvider.logout();
                Navigator.of(context).pushNamed("/Login");
              }),
          Divider(),
        ],
      ),
    );
  }

  _onListTileTap(BuildContext context) {
    Navigator.of(context).pop();
    showDialog<Null>(
      context: context,
      child: new AlertDialog(
        title: const Text('Not Implemented'),
        actions: <Widget>[
          new FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
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
