import 'package:flutter/foundation.dart';
import 'package:lorrystand/services/booking_services.dart';
import 'package:lorrystand/utils/helpers.dart';
class BookingProvider extends ChangeNotifier {

  BookingService _bookingService = BookingService();

  var _booking = {};

  var _bookings = [];

  var _filter = {};

  var _trucks = [];

  int _page = 1;

  bool _isLoading = true;

  get bookings => _bookings;

  get booking => _booking;

  get bids => _booking['bids'] ?? [];

  get bid => _booking['bid'] ?? null;

  get truck => _booking['truck'] ?? null;

  get filter => _filter;

  get trucks => _trucks;

  int get page => _page;

  bool get isLoading => _isLoading;
 

  void resetFilter(){
    _filter.clear();
    _filter.update('booking_status', (value) => 'booking');
    _filter.update('page', (value) => _page);
    notifyListeners();
  }

  void updateFilter(key , value){
    _filter.remove(key);
    _filter.update(key ,(dynamic value) => value.toString(), ifAbsent: () => value.toString() );
    notifyListeners();
    print(_filter);
  }

  resetBooking(){
    _booking = {};
     notifyListeners();
  }

  list() async {
    //_isLoading = true;
    var userType = await getUserType();
    if(userType == 'transporter'){
      _filter.update('booking_status', (value) => 'booking' , ifAbsent: () => 'booking');
      print(_filter);
    }
    
    var response = await _bookingService.list(_filter);
    print(response);
    if(response['status'] == true){
      _bookings = response['data'];  
    }
   //_isLoading = false;
    notifyListeners();
  }

  create(form) async {
    var response = await _bookingService.create(form);
    if(response['status'] == true){
      list(); 
    }
   
    notifyListeners();
    return response;
  }

  fetch(id) async {
    var response = await _bookingService.fetch(id);
    if(response['status'] == true){
      _booking = response['data'];  
    }
   
    notifyListeners();
    return response;
  }

  createBid(id, amount) async {
    var response = await _bookingService.createBid(id ,amount);
    print(response);
    if(response['status'] == true){
    }
   
    notifyListeners();
    return response;
  }

  updateBid(id, amount) async {
    var response = await _bookingService.updateBid(id ,amount);
    if(response['status'] == true){
    }
   
    notifyListeners();
    return response;
  }

  fetchBid(id) async {
    var response = await _bookingService.fetchBid(id);
    if(response['status'] == true){
    }
   
    notifyListeners();
    return response;
  }

  acceptBid(id , bidId) async {
    var response = await _bookingService.acceptBid(id , bidId);
    if(response['status'] == true){
      print(response);
      fetch(id);
    }
       
    notifyListeners();
    return response;
  }

  cancelBid(id , bidId) async {
    var response = await _bookingService.cancelBid(id , bidId);
    print(response);
    if(response['status'] == true){
      print(response);
      fetch(id);
    }
   
    notifyListeners();
    return response;
  }

  cancel(id) async {
    var response = await _bookingService.cancel(id);
    print(response);
    if(response['status'] == true){
     _booking = response['data'];   
    }
   
    notifyListeners();
    return response;
  }

  assignTruck(id, truckId) async{
    var response = await _bookingService.assignTruck(id , truckId);
    print(response);
    if(response['status'] == true){
    }   
    notifyListeners();
    return response;
  }

  removeTruck(id , truckId ) async{
    var response = await _bookingService.assignTruck(id , truckId);
    if(response['status'] == true){
    }   
    notifyListeners();
    return response;
  }


  searchUnattached(searchText) async{
    var response = await _bookingService.seatchTrucks(searchText);
    if(response['status'] == true){
      _trucks = response['data']; 
      //print(_unattachedTrucks); 
    }
   
    notifyListeners();
    return response;
  }

  verifyOtp(id , otp) async{
    var response = await _bookingService.verifyOTP(id , otp);
    if(response['status'] == true){
      fetch(id); 
    }   
    notifyListeners();
    return response;
  }

  driverUpdateStatus(id , status) async{
    var response = await _bookingService.driverUpdateStatus(id , status);
    if(response['status'] == true){
      fetch(id); 
    }   
    notifyListeners();
    return response;
  }

}