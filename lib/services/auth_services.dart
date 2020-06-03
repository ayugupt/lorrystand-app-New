import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lorrystand/services/headers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorrystand/config/app_base.dart';

class AuthService {
 
 //MyDeviceInfo _device_info;// = MyDeviceInfo();

  // Create storage
  Future<Map> login(user) async {
    // var _deviceinfos = MyDeviceInfo.getDeviceDetails();
    Map<String, String> headers = {
      //'Content-Type': 'application/json',
      'Accept':'application/json',
      'X-DEVICE-ID' : "fbfgbbgfgf",
      'X-DEVICE-TOKEN' : "fgffdgdfgfdgdfgdfgfdgdfgdfg",
      'X-DEVICE-TYPE' : "dfgdfgdf",
    };
    

    final response = await http.post('$BASE_URL/${user["type"]}/login', headers: headers, body: {
      'email': user['email'],
      'password': user['password'],
    });

    if (response.statusCode == 200) {   
      //setToken(response.body);

      final parsedJson = jsonDecode(response.body);
      return parsedJson;
    } else {
      if (response.statusCode == 403 || response.statusCode == 500) {
        Fluttertoast.showToast(
            msg: "Invalid Credentials",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
       
      return jsonDecode(response.body);
    }
  }

  Future<Map> register(user) async {
     Map<String, String> headers = {
      //'Content-Type': 'application/json',
      'Accept':'application/json',
      'X-DEVICE-ID' : "fbfgbbgfgf",
      'X-DEVICE-TOKEN' : "fgffdgdfgfdgdfgdfgfdgdfgdfg",
      'X-DEVICE-TYPE' : "dfgdfgdf",
    };
    
    final response = await http.post('$BASE_URL/${user["type"]}/register', headers : headers, body: user);
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
  }

  Future<Map> profile() async {

    Map<String, String> headers = await getHeaders();
    String userType = await getUserType();
    final response = await http.get('$BASE_URL/$userType/profile', headers : headers);
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

  Future<Map> updateProfile(user) async {
    Map<String, String> headers = await getHeaders();
    
    final response = await http.post('$BASE_URL/address/list', headers : headers , body: user);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map> getAddresses() async {
     Map<String, String> headers = await getHeaders();
    
    final response = await http.get('$BASE_URL/address/list', headers : headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map> createAddress(address) async {
     Map<String, String> headers = await getHeaders();
    
    final response = await http.post('$BASE_URL/address/create', headers : headers, body: address);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map> fetchAddress(addressId) async {
     Map<String, String> headers = await getHeaders();
    
    final response = await http.get('$BASE_URL/address/fetch/$addressId');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map> updateAddress(addressId, address) async {
     Map<String, String> headers = await getHeaders();
    
    final response = await http.post('$BASE_URL/address/$addressId/update', headers : headers, body: address);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map> deleteAddress(addressId) async {
     Map<String, String> headers = await getHeaders();
    
    final response = await http.delete('$BASE_URL/address/$addressId', headers : headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map> makeDefaultAddress(addressId) async {
     Map<String, String> headers = await getHeaders();
    
    final response = await http.get('$BASE_URL/address/$addressId', headers : headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return jsonDecode(response.body);
    }
  }

  Future<Map> searchHubs(pincode) async {
     Map<String, String> headers = await getHeaders();
    
    final response = await http.get('$BASE_URL/fetch/delivery-hubs?pincode=$pincode', headers : headers);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      // return User.fromJson(json.decode(response.body));
      return jsonDecode(response.body);
    } else {
      // If that call was not successful, throw an error.
      // throw Exception(response.body);
      return jsonDecode(response.body);
    }
  }
  
}