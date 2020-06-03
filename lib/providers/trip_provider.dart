import 'package:flutter/foundation.dart';
import 'package:lorrystand/services/booking_services.dart';

class TripProvider extends ChangeNotifier {

  BookingService _tripService = BookingService();

  var _trip = {};

  var _trips = [];

  var _filter = {};

  int _page = 1;

  bool _isLoading = false;

  get trips => _trips;

  get trip => _trip;

  get bids => _trip['bids'] ?? [];

  get bid => _trip['bid'] ?? null;

  get truck => _trip['truck'] ?? null;

  get filter => _filter;

  int get page => _page;

  bool get isLoading => _isLoading;


  list() async {
    var response = await _tripService.histories();
    print(response);
    if(response['status'] == true){
      _trips = response['data'];  
    }
   
    notifyListeners();
  }

  fetch(id) async {
    var response = await _tripService.fetch(id);
    if(response['status'] == true){
      _trip = response['data'];  
    }
   
    notifyListeners();
    return response;
  }

}