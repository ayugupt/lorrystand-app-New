import 'package:flutter/material.dart';


import 'package:lorrystand/pages/SplashScreenPage.dart';
import 'package:lorrystand/pages/SignupPage.dart';
import 'package:lorrystand/pages/LoginPage.dart';
import 'package:lorrystand/pages/OtpPage.dart';

import 'package:lorrystand/pages/HomePage.dart';
import 'package:lorrystand/pages/PlacesAutocomplete.dart';

import 'package:lorrystand/pages/ProfilePage.dart';
import 'package:lorrystand/pages/TrucksPage.dart';
import 'package:lorrystand/pages/TripsPage.dart';
import 'package:lorrystand/pages/TripPage.dart';

//Customer
import 'package:lorrystand/pages/customer/CreateBookingPage.dart';

//Driver
import 'package:lorrystand/pages/driver/TruckPage.dart';

//Transporter
import 'package:lorrystand/pages/transporter/TransportPage.dart';
import 'package:lorrystand/pages/transporter/CreateTransportPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreenPage());
      case '/Signup':
        return MaterialPageRoute(builder: (_) => SignupPage());
      case '/Otp':
        return MaterialPageRoute(builder: (_) => OtpPage());
      case '/CreateTransport':
       return MaterialPageRoute(builder: (_) => CreateTransportPage());
      case '/PlaceAutocomplete':
        return MaterialPageRoute(builder: (_) => PlaceAutocomplete());
      case '/search':
        return MaterialPageRoute(builder: (_) => CustomSearchScaffold());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/Profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/Trips':
        return MaterialPageRoute(builder: (_) => TripsPage());
      case '/Trip':
        return MaterialPageRoute(builder: (_) => TripPage(id: args));
      case '/Trucks':
        return MaterialPageRoute(builder: (_) => TrucksPage());
      case '/Driver/Truck':
        return MaterialPageRoute(builder: (_) => TruckPage(id: args));
      case '/Home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/Transport':
        return MaterialPageRoute(builder: (_) => TransportPage());
      case '/CreateBooking':
        return MaterialPageRoute(builder: (_) => CreateBookingPage());
      default:
      // If there is no such named route in the switch statement, e.g. /third
       return MaterialPageRoute(builder: (_) => HomePage());
       //return MaterialPageRoute(builder: (_) => SplashScreenPage());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}