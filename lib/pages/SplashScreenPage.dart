import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreenPage> {
  // Controller _con;

  // SplashScreenState() : super(Controller()) {
  //   _con = controller;
  // }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
       Navigator.of(context).pushReplacementNamed('/Signup');
      // if (currentUser.apiToken == null) {
      //   Navigator.of(context).pushReplacementNamed('/Login');
      // } else {
      //   Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _con.scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.directions_car,
                size: 90,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              Text(
                'Lorrystand',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)),
              ),
              SizedBox(height: 50),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).scaffoldBackgroundColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}