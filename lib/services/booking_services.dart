import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lorrystand/models/booking_model.dart';
import 'package:lorrystand/services/headers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorrystand/config/app_base.dart';


class BookingService {
  //BookingService._privateConstructor();
  //static final BookingService instance = BookingService._privateConstructor();
  
  Future<Map> list(params) async {

    Map<String, String> headers = await getHeaders();
    final userType = await getUserType();
    String query = getQueryString(params);
    final response = await http.get('$BASE_URL/$userType/booking/list?$query', headers : headers);
    
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

  Future<Map> enquires(params) async {

    Map<String, String> headers = await getHeaders();
    final userType = await getUserType();

    String query = getQueryString(params);
    final response = await http.get('$BASE_URL/$userType/booking/list?$query', headers : headers);
    
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

  Future<Map> bids(params) async {

    Map<String, String> headers = await getHeaders();
    final userType = await getUserType();
    String query = getQueryString(params);
    final response = await http.get('$BASE_URL/$userType/booking/list?$query', headers : headers);
    
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

  Future<Map> fetch(id) async {

    Map<String, String> headers = await getHeaders();
    final userType = await getUserType();
    final response = await http.get('$BASE_URL/$userType/booking/fetch/$id', headers : headers);
    
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

  Future<Map> histories() async {

    Map<String, String> headers = await getHeaders();
    final userType = await getUserType();
    final response = await http.get('$BASE_URL/$userType/booking/histories', headers : headers);
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      if (response.statusCode == 400) {
      }
      return jsonDecode(response.body);
    }
  }

  Future<Map> create(booking) async {
    try {
      Map<String, String> headers = await getHeaders();

      var data = mapObject(booking);
      final response = await http.post('$BASE_URL/customer/booking/create', headers : headers, body: data);

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

  Future<Map> cancel(id) async {
    try {
      Map<String, String> headers = await getHeaders();

      
      final userType = await getUserType();
      final response = await http.get('$BASE_URL/$userType/booking/$id/cancel', headers : headers);
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

  Future<Map> createBid(id , amount) async {
    try {
      Map<String, String> headers = await getHeaders();
      //var data = mapObject(booking);
      final response = await http.post('$BASE_URL/transporter/booking/$id/create/bid?amount=$amount', headers : headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
          var data = jsonDecode(response.body);
          Fluttertoast.showToast(
              msg: "${data['message']}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
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
      print(e);
      throw e;
    } catch (e) {

      print(e);
      throw e;
    }
  }

  Future<Map> updateBid(id , amount) async {
    try {
      Map<String, String> headers = await getHeaders();

      //var data = mapObject(booking);
      final response = await http.post('$BASE_URL/transporter/booking/$id/update/bid?amount=$amount', headers : headers);

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

 Future<Map> fetchBid(id) async {
    try {
      Map<String, String> headers = await getHeaders();

      //var data = mapObject(booking);
      final response = await http.get('$BASE_URL/transporter/booking/$id/fetch/bid', headers : headers);

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

  Future<Map> removeBid(id) async {
    try {
      Map<String, String> headers = await getHeaders();

      //var data = mapObject(booking);
      final response = await http.delete('$BASE_URL/transporter/booking/$id/cancel/bid', headers : headers);

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

  Future<Map> acceptBid(id , bidId) async {
    try {
      Map<String, String> headers = await getHeaders();

      //var data = mapObject(booking);
      final response = await http.get('$BASE_URL/customer/booking/$bidId/accept/bid?booking_id=$id', headers : headers);

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

  Future<Map> cancelBid(id , bidId) async {
    try {
      Map<String, String> headers = await getHeaders();

      //var data = mapObject(booking);
      final response = await http.get('$BASE_URL/customer/booking/$bidId/cancel/bid?booking_id=$id', headers : headers);

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

  Future<Map> seatchTrucks(searchText) async {
    try {
      Map<String, String> headers = await getHeaders();

      //var data = mapObject(booking);
      final response = await http.get('$BASE_URL/transporter/booking/unassigned/truck/suggestions?serachText=$searchText', headers : headers);

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

  Future<Map> assignTruck(id , truckId) async {
    try {
      Map<String, String> headers = await getHeaders();

      //var data = mapObject(booking);
      final response = await http.post('$BASE_URL/transporter/booking/$id/update/truck?truck_id=$truckId', headers : headers);

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

  Future<Map> getCities() async {

    Map<String, String> headers = await getHeaders();
    final response = await http.get('$BASE_URL/fetch/cities', headers : headers);
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

  Future<Map> getTruckTypes() async {

    Map<String, String> headers = await getHeaders();
    final response = await http.get('$BASE_URL/fetch/truck-types', headers : headers);
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

  Future<Map> getMaterialTypes() async {

    Map<String, String> headers = await getHeaders();
    final response = await http.get('$BASE_URL/fetch/material-types', headers : headers);
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

  Future<Map> driverUpdateStatus(id , status) async {
    try {
      Map<String, String> headers = await getHeaders();

      //var data = mapObject(booking);
      final response = await http.get('$BASE_URL/driver/booking/$id/update-status?status=$status', headers : headers);

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

  Future<Map> verifyOTP(id , otp) async {
    try {
      Map<String, String> headers = await getHeaders();

      //var data = mapObject(booking);
      final response = await http.post('$BASE_URL/driver/booking/$id/verify-otp?otp=$otp', headers : headers);

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

  // Future<dynamic> _fetchJSON(String url) async {
  //   final response = await http.get(url).timeout(Duration(seconds: 25), onTimeout: () {
  //     throw Error();
  //   });

  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     throw ServerErrorException("Error retrieving data");
  //   }
  // }

}