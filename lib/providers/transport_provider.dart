import 'package:flutter/foundation.dart';
import 'package:lorrystand/services/transport_services.dart';

class TransportProvider extends ChangeNotifier {


  TransportService _transportService = TransportService();

  var _form = {};

  var _transport = {};

  get form => _form;

  get transport => _transport;


  create(form) async {
    var response = await _transportService.create(form);
    if(response['status'] == true){
      //_transport = response['data'];  
      fetch();
    }
   
    notifyListeners();
    return response;
  }

  fetch() async {
    var response = await _transportService.fetch();
    if(response['status'] == true){
      _transport = response['data'];
      //print(_transport);  
    }
   
    notifyListeners();
    return response;
  }
  
}