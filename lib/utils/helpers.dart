import "package:intl/intl.dart";

import 'package:shared_preferences/shared_preferences.dart';

class Helpers {
  static NumberFormat _numberFormatter;
  static DateFormat _dateFormatter;

  static NumberFormat get numberFormatter {
    if (_numberFormatter != null) {
      return _numberFormatter;
    }
    _numberFormatter = NumberFormat();
    return _numberFormatter;
  }

  static DateFormat get dateFormatter {
    if (_dateFormatter != null) {
      return _dateFormatter;
    }
    _dateFormatter = DateFormat('d MMM, HH:mm');

    return _dateFormatter;
  }
}

 setToken(String value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token' , value);
  }

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }

  setUserType(String value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('user_type' , value);
  }

  getUserType() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userType = localStorage.getString('user_type');
    return userType;
  }
