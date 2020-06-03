import 'package:flutter/foundation.dart';
import 'package:lorrystand/services/truck_services.dart';

class TruckProvider extends ChangeNotifier {


  TruckService _truckService = TruckService();

  var _form = {};

  var _truck = {};

  var _transport = {};

  var _trucks = [];

  var _unattachedTrucks = [];

  get trucks => _trucks;

  get truck => _truck;

  get form => _form;

  get transport => _transport;

  get unattachedTrucks => _unattachedTrucks;

  TruckProvider(){
    list();
  }


  list() async {
    var response = await _truckService.list();
    if(response['status'] == true){
      _trucks = response['data'];  
      //print(response);
    }
   
    notifyListeners();
    return response;
  }

  create(form) async {
    var response = await _truckService.create(form);
    if(response['status'] == true){
      list(); 
    }
   
    notifyListeners();
    return response;
  }

  fetch(id) async {
    var response = await _truckService.fetch(id);
    if(response['status'] == true){
      _truck = response['data'];  
    }
   
    notifyListeners();
    return response;
  }

  attach(id, index) async{
    var response = await _truckService.attach(id);
    if(response['status'] == true){
      //_truck = response['data'];  
       _unattachedTrucks.removeAt(index);
      //print(response);
    }
   
    notifyListeners();
    return response;
  }

  unAttach(id , index) async{
    var response = await _truckService.unattach(id);
    if(response['status'] == true){
      //_truck = response['data'];  
      //_trucks.removeAt(index);
      //print("xxxxxxxxxxxxx-----------------xxxxxxxxxxxxxx");
      //print(response);
    }
   
    notifyListeners();
    return response;
  }


  searchUnattached(searchText) async{
    var response = await _truckService.searchUnattached(searchText);
    if(response['status'] == true){
      _unattachedTrucks = response['data']; 
      //print(_unattachedTrucks); 
    }
   
    notifyListeners();
    return response;
  }

  cancel() async {
    var response = await _truckService.create(_form);
    if(response['status'] == true){
     _truck = response['data'];   
    }
   
    notifyListeners();
    return response;
  }
  
}