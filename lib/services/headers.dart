import 'package:shared_preferences/shared_preferences.dart';

import 'package:fluttertoast/fluttertoast.dart'; 

import 'package:flutter/material.dart';


Future<Map<String, String>> getHeaders() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  //final token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYjNhY2E3MTdlYWMzNGQ1NTFkMjMxOTI0OTVkOWI3ZGRkYzY3ZTcxYWMyODJiNGE0YjFhYjNhYjU5YjFkYzhhYzFkMjI5OWEwZjkxNWIwMjciLCJpYXQiOjE1ODA4OTM5NTQsIm5iZiI6MTU4MDg5Mzk1NCwiZXhwIjoxNjEyNTE2MzU0LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.piUgk2rJkkndOQy0PwB3YprcVC_xt9SUfOC5abGZL5SSFzMkZXFVl0vN_287CYX4MVCbNRNE6uXqtO8ZbIP8-wEG7Gz8B-YrmLWmy4-6HczBx9RKXgh_upICK2OmQrAacmmDBBpER8r03ZqWqmZo4rf4odKPnyp55lcpOPAX5RJNs4p_lhWV8xyo_MDdIPOCjwr3w6R9zE88nihDIkX6FoJlt_-d8aApwvGX0qsSxZ-IFO8CJ0GGhlXOiyukHdbH_zgYl9PPcrkSGeIhXpT5WOY9EGkSJJutP6ZSgRnYDC9DBb4blN3GNfW3gK3jg6oDaz2m2I4A8ABB_mgYZE0nTVzEzFj8375zPQp-pkyFcD3z4bt3IoPF2SqHvsiniY9DK5zodu_G-rLXy9EHDfSsYJJlwxbEE-VTF9IxfgWwSY8sEZ1mR0e8TPjg7aLZK4cK-NbrVqCRurZkdSOo93SDXdqFjPN2nOkymUzFGWBAvyVlOuN629oZ1ooF4CIU2vww_oHnopYJKoofAOfsLOJItqGwF9fPOpU6UqTttNdSNzEr3qeQjt13iHReR5BewVV3j-XtIRz6SuCwea7xfIo0QIyHBfWOkISd9VTQiQsyJvaImt8JP83eB0aVRn61s97ofb2diYvhutiLL4T8mcXGNKs7gmiltlal3iAnpFn1Qqw";
  final token = prefs.get('token') ?? null;
  Map<String, String> headers = {
    //'Content-Type': 'application/json',
    'Accept':'application/json',
    'Authorization' : 'Bearer $token'
   // 'Guest-Order-Token': prefs.getString('orderToken') == null  ? ''  : prefs.getString('orderToken')
  };
  
  return headers;
}

getUserType() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var userType = localStorage.getString('user_type');
  return userType;
}

String parseQueryParams({params}){
  if(params == null) return "";
  var str = "?";
  params.forEach((key , value) => str += "$key=$value&" );
  return str;
}


class TimeoutException implements Exception {
  final String message = 'Server timeout';
  TimeoutException();
  String toString() => message;
}

class ServerException implements Exception {
  final String message = 'Server busy';
  ServerException();
  String toString() => message;
}

class ServerErrorException implements Exception {
  String message;
  ServerErrorException(this.message);

  String toString() => message;
}

Map<String, String> mapObject(params){
    Map<String, String> data = {};
      params.forEach((key, value) {
        data[key] = value.toString();
      });
      return data;
  }

  String getQueryString(Map params, {String prefix: '&', bool inRecursion: false}) {

    String query = '';

    params.forEach((key, value) {

        if (inRecursion) {
            key = '[$key]';
        }

        if (value is String || value is int || value is double || value is bool) {
            query += '$prefix$key=$value';
        } else if (value is List || value is Map) {
            if (value is List) value = value.asMap();
            value.forEach((k, v) {
                query += getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
            });
        }
   });

   return query;
}

 void showToasts(message){    
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

const kTimeoutDuration = Duration(seconds: 25);