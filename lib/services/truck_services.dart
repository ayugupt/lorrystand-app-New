import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lorrystand/models/booking_model.dart';
import 'package:lorrystand/services/headers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorrystand/config/app_base.dart';


class TruckService {

  Future<Map> list() async {

    Map<String, String> headers = await getHeaders();
    final userType = await getUserType();
    final response = await http.get('$BASE_URL/$userType/truck/list', headers : headers);
    
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      // return User.fromJson(json.decode(response.body));
      return jsonDecode(response.body);
    } else {
      if (response.statusCode == 400) {
        // Fluttertoast.showToast(
        //     msg: 'Email already exist',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIos: 1,
        //     fontSize: 16.0);
      }
      return jsonDecode(response.body);
    }
  }

  Future<Map> create(form) async {
    try {
      Map<String, String> headers = await getHeaders();
      var data = mapObject(form);
      final response = await http.post('$BASE_URL/driver/truck/create', headers : headers, body: data);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (response.statusCode == 400) {
          // Fluttertoast.showToast(
          //     msg: 'Email already exist',
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIos: 1,
          //     fontSize: 16.0);
        }
        return jsonDecode(response.body);
      }
    } on PlatformException catch (_) {
      throw ServerException();
    } on Exception catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

   Future<Map> edit(form) async {
    try {
      Map<String, String> headers = await getHeaders();
      var data = mapObject(form);
      final response = await http.post('$BASE_URL/driver/truck/${form['id']}/update', headers : headers, body: data);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (response.statusCode == 400) {
          // Fluttertoast.showToast(
          //     msg: 'Email already exist',
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIos: 1,
          //     fontSize: 16.0);
        }
        return jsonDecode(response.body);
      }
    } on PlatformException catch (_) {
      throw ServerException();
    } on Exception catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<Map> fetch(id) async {
     Map<String, String> headers = await getHeaders();

    String userType = await getUserType();
    final response = await http.get('$BASE_URL/$userType/truck/fetch/$id', headers : headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map> attach(id) async {
     Map<String, String> headers = await getHeaders();

    final response = await http.get('$BASE_URL/transporter/truck/$id/attached', headers : headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map> unattach(id) async {
     Map<String, String> headers = await getHeaders();

    final response = await http.get('$BASE_URL/transporter/truck/$id/unattach', headers : headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map> searchUnattached(searchText) async {
     Map<String, String> headers = await getHeaders();

    final response = await http.get('$BASE_URL/transporter/fetch/unattached/trucks?searchText=' + searchText, headers : headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

}