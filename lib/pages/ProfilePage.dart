import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lorrystand/widgets/network_image.dart';

import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart';

import 'package:lorrystand/config/app_config.dart' as config;

class ProfilePage extends StatelessWidget {
  Color color1 = new Color(0xff212732);
  Color color2 = new Color(0xfffed226);

  static final String path = "lib/src/pages/profile/profile3.dart";
  final image = "";
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    userProvider.getProfile();
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            // SizedBox(
            //   height: 250,
            //   width: double.infinity,
            //   child: Container(color: Colors.lightGreen,)//PNetworkImage(image, fit: BoxFit.cover,),
            // ),
            Container(
              width: config.App(context).appWidth(100),
              height: config.App(context).appHeight(60),
              child: ClipPath(
                child: Container(
                  color: color1,
                ),
                clipper: Design(),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.fromLTRB(16.0, kToolbarHeight + 40, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        // margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 96.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${userProvider.fullName}",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(
                                        "${userProvider.userRole.toUpperCase()}"),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            // Row(
                            //   children: <Widget>[
                            //     Expanded(child: Column(
                            //       children: <Widget>[
                            //         Text("285"),
                            //         Text("Likes")
                            //       ],
                            //     ),),
                            //     Expanded(child: Column(
                            //       children: <Widget>[
                            //         Text("3025"),
                            //         Text("Comments")
                            //       ],
                            //     ),),
                            //     Expanded(child: Column(
                            //       children: <Widget>[
                            //         Text("650"),
                            //         Text("Favourites")
                            //       ],
                            //     ),),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/150"),
                                fit: BoxFit.cover)),
                        margin: EdgeInsets.only(left: 16.0, top: 10.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("User information"),
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Email"),
                          subtitle: Text("${userProvider.email}"),
                          leading: Icon(Icons.email),
                        ),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text("${userProvider.mobile}"),
                          leading: Icon(Icons.phone),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            AppBar(
              //backgroundColor: Colors.green,
              title: Container(
                child: Text('Profile',
                    style: TextStyle(
                        color: color1,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                color: color2,
              ),
              elevation: 0,
              backgroundColor: color1,
              iconTheme: IconThemeData(color: color2),
              centerTitle: true,
            )
          ],
        ),
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
