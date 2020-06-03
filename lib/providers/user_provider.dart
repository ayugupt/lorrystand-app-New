import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lorrystand/services/auth_services.dart';
import 'package:lorrystand/services/booking_services.dart';

enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider extends ChangeNotifier {

  UserProvider(){
    getBasicData();
  }

  //Authentication
  AuthService _authService = AuthService();
  BookingService _bookingService = BookingService();

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;
  String _profile = "";

  Status _status = Status.Uninitialized;
  Status get status => _status;

  var _cities = [];
  get cities => _cities;

  var _truckTypes = [];
  get truckTypes => _truckTypes;

  var _materialTypes = [];
  get materialTypes => _materialTypes;

  //Users
  var _user = {};
  get user => _user;
  String get fullName => _user['fullname'] ?? "";
  String get email => _user['email'] ?? "";
  String get mobile => _user['mobile'] ?? "";
  String get userRole => _user['user_type'] ?? "guest";
  String get profile => _profile;

  
  get transport => _user['transport'] ?? {};
  
  //Address
  List<dynamic> _addresses = [];
  List<dynamic> get addresses => _addresses;
  String _pincode = "";
  String get pincode => _pincode;
  var _hub = null;
  dynamic get hub => _hub; 

  //Error & Message
  List<dynamic> _errors = [];
  List<dynamic> get errors => _errors;
  

  loggedInUser(user) async {
    var response = await _authService.login(user);
    var token;    
    if(response['status'] == true){
      token = response['data']['token']; 
      
      setUserType(response['data']['type']);
    }
    if (token != null) {
      setToken(token);
      _isAuthenticated = true;  
      getProfile();      
    } else {
      _isAuthenticated = false;
    }
   
    notifyListeners();
    return response;
  }

  registerUser(user) async {
    var response = await _authService.register(user);
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String token = prefs.getString('token');
    // if (token != null) {
    //   _isAuthenticated = true;
    //   notifyListeners();
    // } else {
    //   _isAuthenticated = false;
    //   notifyListeners();
    // }
    return response;
  }
  
  getProfile() async{
    var response = await _authService.profile();
    if(response['status'] == true){
      _user = response['data'];
      _profile = _user['profile'] ?? "";
      //print(_user);
      _isAuthenticated = true;
      notifyListeners(); 
    }else{
      _isAuthenticated = false;
      notifyListeners();
      logout();       
    }
  }  

  getBasicData(){
    if(_user.isEmpty){
      getProfile();
    }

    if(_cities.length == 0){
      getCities();
    }
    if(_truckTypes.length == 0){
      getTruckTypes();
    }
    if(_materialTypes.length == 0){
      getMaterialTypes();
    }
  }

  getCities() async {
    var response = await _bookingService.getCities();
    if (response['status'] == true) {
      _cities = response['data'];
      //response['data'].forEach((i)=>_cities.add(City.fromJson(i)));
      notifyListeners();
    }
    return response;
  }

  getTruckTypes() async {
    var response = await _bookingService.getTruckTypes();
    if (response['status'] == true) {
      _truckTypes = response['data'];
      notifyListeners();
    }
    return response;
  }

  getMaterialTypes() async {
    var response = await _bookingService.getMaterialTypes();
    if (response['status'] == true) {
      _materialTypes = response['data'];
      //response['data'].forEach((i)=>_cities.add(City.fromJson(i)));
      notifyListeners();
    }
    return response;
  }

  updateProfile(user) async{
    var response = await _authService.updateProfile(user);
    if(response['status'] == true){
      _user = response['data'];
      notifyListeners(); 
    }
  } 

  setToken(String value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token' , value);
  }

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }

  setUserType(String value) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('user_type' , value);
  }

  getUserType() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userType = localStorage.getString('user_type');
    return userType;
  }

  logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('user_type');
    _user = {};
    _isAuthenticated = false;
    notifyListeners();
  }
}