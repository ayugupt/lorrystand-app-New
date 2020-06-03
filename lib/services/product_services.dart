import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:lorrystand/config/app_base.dart';
import 'package:lorrystand/services/headers.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<String> _loadProduct() async{
  return await rootBundle.loadString('assets/address.json');
}

Future loadAddress() async{

  String jsonAddress = await _loadProduct();
  final jsonResponce = json.decode(jsonAddress);
  return jsonResponce;

}

Future<dynamic> seachSuggestions(searchText) async {
  Map<String, String> headers = await getHeaders();  
  final response = await http.get('$BASE_URL/fetch/product-search/suggestions?searchText=$searchText' ,headers : headers);
  if (response.statusCode == 200) {
    final parsedJson = jsonDecode(response.body);
    return parsedJson;
  } else {      
    return jsonDecode(response.body);
  }
}

Future<dynamic> getBanners({params}) async {
  Map<String, String> headers = await getHeaders();  
  String paramsStr = parseQueryParams(params : params);
  final response = await http.get('$BASE_URL/banner/list$paramsStr' ,headers : headers);
  if (response.statusCode == 200) {
    final parsedJson = jsonDecode(response.body);
    //  Fluttertoast.showToast(
    //         msg: 'Email already exist',
    //         toastLength: Toast.LENGTH_SHORT,
    //         gravity: ToastGravity.CENTER,
    //         timeInSecForIos: 1,
    //         fontSize: 16.0);
    return parsedJson;
  } else {      
    return jsonDecode(response.body);
  }
}

Future<dynamic> getCategories({params}) async {
  Map<String, String> headers = await getHeaders();
  String paramsStr = parseQueryParams(params : params);
  final response = await http.get('$BASE_URL/category/list$paramsStr' ,headers : headers);
  if (response.statusCode == 200) {
    final parsedJson = jsonDecode(response.body);
    return parsedJson;
  } else {      
    return jsonDecode(response.body);
  }
}

Future<dynamic> getAllProducts({params}) async {
  Map<String, String> headers = await getHeaders();
  String paramsStr = parseQueryParams(params : params);
  final response = await http.get('$BASE_URL/product/list$paramsStr' ,headers : headers); 
  if (response.statusCode == 200) {
    final parsedJson = jsonDecode(response.body);
    return parsedJson;
  } else {      
    return jsonDecode(response.body);
  } 
}

Future<dynamic> getProduct(productId) async {
  Map<String, String> headers = await getHeaders();
  //String paramsStr = parseQueryParams(params : params);
  final response = await http.get('$BASE_URL/product/fetch/$productId' ,headers : headers);
  if (response.statusCode == 200) {
    final parsedJson = jsonDecode(response.body);
    return parsedJson;
  } else {      
    return jsonDecode(response.body);
  }
}

Future<dynamic> getSuggestions(searchtext) async{
  Map<String, String> headers = await getHeaders();
  //String paramsStr = parseQueryParams(params : params);
  final response = await http.get('$BASE_URL/product/suggestions?searchText=$searchtext' ,headers : headers);
  if (response.statusCode == 200) {
    final parsedJson = jsonDecode(response.body);
    return parsedJson;
  } else {      
    return jsonDecode(response.body);
  }
}

