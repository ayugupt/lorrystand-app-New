import 'package:flutter/material.dart';

import 'package:lorrystand/config/app_config.dart' as config;
//import '../controllers/user_controller.dart';
import 'package:lorrystand/widgets/BlockButtonWidget.dart';
//import '../repository/user_repository.dart' as userRepo;
import 'package:lorrystand/providers/booking_provider.dart'; 
import 'package:lorrystand/providers/user_provider.dart'; 
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:lorrystand/services/auth_services.dart'; 

class LoginPage extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginPage> {
  // UserController _con;
   //String _currentIndex = 'customer';
   bool _isLoading = false;
   bool _hidePassword = true;
   var user = {};
   
   GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>();
   GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
   AuthService userProvider = new AuthService();
   //UserProvider userProvider;

  // _LoginWidgetState() : super(UserController()) {
  //   _con = controller;
  // }
  @override
  void initState() {
    super.initState();
    this.user['type'] = 'customer';
   //userProvider = Provider.of<UserProvider>(context);

    // if (userRepo.currentUser?.apiToken != null) {
    //   Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    // }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
                child: Container(
                  width: config.App(context).appWidth(100),
                  height: config.App(context).appHeight(29.5),
                  decoration: BoxDecoration(color: Colors.greenAccent[700]),
                ),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(29.5) - 160,
              child: Container(
                width: config.App(context).appWidth(84),
                height: config.App(context).appHeight(29.5),
                child: Column(
                  children: <Widget>[
                    new Text(
                      'Login Account',
                      style: Theme.of(context).textTheme.headline2.merge(
                          TextStyle(color: Colors.white)),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Sign In Button
                        new FlatButton(
                          color: this.user['type'] == 'customer' ? Colors.pinkAccent[400] : Colors.white,
                          textColor: this.user['type'] == 'customer' ? Colors.white : Colors.black,
                          onPressed: () {
                            // _tabController.animateTo(0);
                            setState(() {
                              this.user['type'] = 'customer';
                            });
                          },
                          child: new Text("Customer"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: new FlatButton(
                            color: this.user['type'] == 'driver' ? Colors.pinkAccent[400] : Colors.white,
                            textColor: this.user['type'] == 'driver' ? Colors.white : Colors.black,
                            onPressed: () {
                              //_tabController.animateTo(1);
                              setState(() {
                                this.user['type'] = 'driver';
                              });
                            },
                            child: new Text("Driver"),
                          ),
                        ),

                        new FlatButton(
                          color: this.user['type'] == 'transporter' ? Colors.pinkAccent[400] : Colors.white,
                          textColor: this.user['type'] == 'transporter' ? Colors.white : Colors.black,
                          onPressed: () {
                            //_tabController.animateTo(1);
                            setState(() {
                              this.user['type'] = 'transporter';
                            });
                          },
                          child: new Text("Transporter"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            Positioned(
              top: config.App(context).appHeight(29.5) - 50,
              child: Container(
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 50,
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                      )
                    ]),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
                width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (input) {
                          setState(() {
                            this.user['email'] = input;
                          });
                        },
                        validator: (input) => !input.contains('@') ? 'Should be a valid email' : null,
                        decoration: InputDecoration(
                          labelText:'Email',
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'user@example.com',
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onChanged: (input) {
                          setState(() {
                            this.user['password'] = input;
                          });
                        },
                        validator: (input) => input.length < 3 ? 'Should be more than 6 letters' : null,
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: '••••••••••••',
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = ! _hidePassword;
                              });
                            },
                            color: Theme.of(context).focusColor,
                            icon:  _hidePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 20),
                      _isLoading ? FloatingActionButton(
                        //backgroundColor: Colors.green,
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 10.0,
                          width: 10.0,
                        ), 
                        onPressed: null
                      )
                      : BlockButtonWidget(
                        text: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                        onPressed: ()  {
                          login(userProvider);
                          //print(this.user);
                          //var response = userProvider.loggedInUser(user);
                          //print(response);
                        },
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      forgot_password();
                      // Navigator.of(context).pushReplacementNamed('/SignUp');
                    },
                    textColor: Theme.of(context).hintColor,
                    child: Text('I forgot password?'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/Signup');
                    },
                    textColor: Theme.of(context).hintColor,
                    child: Text("I don't have an account?"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void forgot_password() async{
      Navigator.of(context).pushReplacementNamed('/Otp');
  }

   void login(UserProvider userProvider) async {

    setState(() {
      _isLoading = false;
    });
    
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      //var response = await userProvider.incrementCounters(user);
      var response = await userProvider.loggedInUser(user);
      if(userProvider.isAuthenticated){
        print("login success");
        Navigator.of(context).pushReplacementNamed('/Home');
      }else{
        showToasts("Please enter vaild username & password.");
      }
      // await userProvider.loggedInUser(user).then((value) {
      //   //print(value.apiToken);
      //   //&& value.apiToken != null
      //   print(value);
      //   if (value != null ) {
      //     // SnackBar(
      //     //   content: Text(''),
      //     // );
      //     Navigator.of(context).pushReplacementNamed('/Home');
      //   } else {
      //     setState(() {
      //       _isLoading = false;
      //     });
      //     SnackBar(
      //       content: Text('S.current.wrong_email_or_password'),
      //     );
      //   }
      // });
    }
  }

  void showToasts(message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}