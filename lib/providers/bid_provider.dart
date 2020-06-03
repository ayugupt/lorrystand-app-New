import 'package:flutter/foundation.dart';
import 'package:lorrystand/services/booking_services.dart';

class BidProvider extends ChangeNotifier {

  BookingService _bookingService = BookingService();

  var _bids = [];

  get bids => _bids; 

  list() async{
    var response = await _bookingService.bids({'booking_status' : 'bidding'});
    print(response);
    if(response['status'] == true){
      _bids = response['data']; 
    }
   
    notifyListeners();
  }
}