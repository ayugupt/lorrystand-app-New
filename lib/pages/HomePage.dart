import 'package:flutter/material.dart';
import 'package:lorrystand/pages/LoginPage.dart';
import 'package:lorrystand/providers/user_provider.dart';
import 'package:lorrystand/widgets/HomeCustomer.dart';
import 'package:lorrystand/widgets/HomeDriver.dart';
import 'package:lorrystand/widgets/HomeTransporter.dart';
import 'package:provider/provider.dart';

import 'customer/CreateBookingPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    String role = userProvider.userRole;

    if (role == 'transporter')
      return HomeTransporterPage();
    else if (role == 'driver')
      return HomeDriverPage();
    else if (role == 'customer')
      return CreateBookingPage();
    else
      return LoginPage();
  }
}
