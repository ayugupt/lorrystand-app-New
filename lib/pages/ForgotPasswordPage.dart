import 'package:flutter/material.dart';

import 'package:lorrystand/config/app_config.dart' as config;
import 'package:lorrystand/languages/i18n.dart';
//import '../controllers/user_controller.dart';
import 'package:lorrystand/widgets/BlockButtonWidget.dart';
//import '../repository/user_repository.dart' as userRepo;

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordPage> {
  // UserController _con;
   int _currentIndex = 0;
   bool _hidePassword = true;
   var user = {};
   GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>();

  // _LoginWidgetState() : super(UserController()) {
  //   _con = controller;
  // }
  @override
  void initState() {
    super.initState();
    // if (userRepo.currentUser?.apiToken != null) {
    //   Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        //key: _con.scaffoldKey,
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
                  child: new AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    leading: new InkWell(
                      borderRadius: BorderRadius.circular(30.0),
                      child: new Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/Login');
                      },
                    ),
                    centerTitle: true,
                  ),
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
                      'Reset Password',
                      style: Theme.of(context).textTheme.headline2.merge(
                          TextStyle(color: Theme.of(context).primaryColor)),
                    ),                    
                  ],
                ),
              ),
            ),
            
            Positioned(
              top: config.App(context).appHeight(29.5) - 50,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
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
                        onSaved: (input) => user['password'] = input,
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
                            icon: _hidePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
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
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => user['confirm_password'] = input,
                        validator: (input) => input.length < 3 ? 'Should be more than 6 letters' : null,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: '••••••••••••',
                          hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
                          // suffixIcon: IconButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       _hidePassword = ! _hidePassword;
                          //     });
                          //   },
                          //   color: Theme.of(context).focusColor,
                          //   icon: Icon(Icons.visibility_off),
                          // ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 20),
                      BlockButtonWidget(
                        text: Text(
                          'Reset Password',
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Colors.green,
                        onPressed: () {
                         // _con.login();
                        },
                      ),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),            
          ],
        ),
      ),
    );
  }

   void login() async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      // repository.login(user).then((value) {
      //   //print(value.apiToken);
      //   if (value != null && value.apiToken != null) {
      //     scaffoldKey.currentState.showSnackBar(SnackBar(
      //       content: Text(S.current.welcome + value.name),
      //     ));
      //     Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Pages', arguments: 2);
      //   } else {
      //     scaffoldKey.currentState.showSnackBar(SnackBar(
      //       content: Text(S.current.wrong_email_or_password),
      //     ));
      //   }
      // });
    }
  }
}