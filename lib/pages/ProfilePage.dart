import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lorrystand/widgets/network_image.dart';


import 'package:provider/provider.dart';
import 'package:lorrystand/providers/user_provider.dart'; 

class ProfilePage extends StatelessWidget {
  static final String path = "lib/src/pages/profile/profile3.dart";
  final image = "";
  @override
  Widget build(BuildContext context){
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
              margin: EdgeInsets.fromLTRB(16.0, kToolbarHeight + 40, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                       // margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 96.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${userProvider.fullName}", style: Theme.of(context).textTheme.headline6,),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text("${userProvider.userRole.toUpperCase()}"),
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
                            image: NetworkImage("https://via.placeholder.com/150"),
                            fit: BoxFit.cover
                          )
                        ),
                        margin: EdgeInsets.only(left: 16.0 , top: 10.0),
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
                        ListTile(title: Text("User information"),),
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
              title: Text('Profile'),
              elevation: 0,
            )
          ],
        ),
      ),
    );
  }
}