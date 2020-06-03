import 'package:flutter/foundation.dart';
import 'package:lorrystand/services/booking_services.dart';

class EnquiryProvider extends ChangeNotifier {

  BookingService _bookingService = BookingService();

  var _enquires = [];

  get enquires => _enquires;

  EnquiryProvider(){
    //list();
  }

  getBooking() async{
    //print(_enquires);
    if(_enquires.length == 0){
      list();
    }
  }


  list() async {
    var response = await _bookingService.enquires({'booking_status' : 'enquiry'});
    print(response);
    if(response['status'] == true){
      _enquires = response['data'];  
      //print(_enquires);
    }
   
    notifyListeners();
  }
}