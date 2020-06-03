import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lorrystand/models/booking_model.dart';
import 'package:lorrystand/services/headers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorrystand/config/app_base.dart';


class TransportService {

  
  Future<Map> create(form) async {
     Map<String, String> headers = await getHeaders();
    
    var data = mapObject(form);
    String userType = await getUserType();
    final response = await http.post('$BASE_URL/$userType/transport/create', headers : headers, body: data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map> fetch() async {
     Map<String, String> headers = await getHeaders();

    String userType = await getUserType();
    final response = await http.get('$BASE_URL/$userType/fetch/transport', headers : headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map> edit(form) async {
     Map<String, String> headers = await getHeaders();
    var data = mapObject(form);
    String userType = await getUserType();
    final response = await http.post('$BASE_URL/$userType/transport/update', headers : headers, body: data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }


}