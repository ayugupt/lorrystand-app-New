import 'package:flutter/foundation.dart';
import 'package:lorrystand/services/booking_services.dart';

class PaymentProvider extends ChangeNotifier {

  BookingService _bookingService = BookingService();

  var _payments = [];

  get bids => _payments;

  PaymentProvider(){
    getPayment();
  }

  getPayment() async{
    if(_payments.length == 0){
      list();
    }
  }

  list() async{
    var response = await _bookingService.bids({});
    if(response['status'] == true){
      _payments = response['data']; 
    }
   
    notifyListeners();
  }
}