import 'package:flutter/material.dart';

import 'package:lorrystand/config/app_config.dart' as config;
import 'package:lorrystand/widgets/BlockButtonWidget.dart'; 
import 'package:lorrystand/providers/user_provider.dart'; 
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}


class _SignUpWidgetState extends State<SignupPage> {
  // UserController _con;
  bool _hidePassword = true;
  GlobalKey<FormState> loginFormKey =  new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var user = {};
  // _SignUpWidgetState() : super(UserController()) {
  //   _con = controller;
  // }

  //String _currentIndex = 'customer';
  @override
  void initState() {
    super.initState();
    this.user['type'] = 'customer';
   //userProvider = Provider.of<UserProvider>(context);

    // if (userRepo.currentUser?.apiToken != null) {
    //   Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
    // }
  }
  

  bool _isLoading = false;

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
                      'Create Lorrystand Account',
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
                    color: Colors.white,
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
                            this.user['first_name'] = input;
                          });
                        },
                        validator: (input) => input.length < 3
                            ? 'should be more than 3 letters'
                            : null,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'First Name',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.person_outline,
                              color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                         onChanged: (input) {
                          setState(() {
                            this.user['last_name'] = input;
                          });
                        },
                        validator: (input) => input.length < 3
                            ? 'should be more than 3 letters'
                            : null,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Last name',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.person_outline,
                              color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => user['mobile'] = input, onChanged: (input) {
                          setState(() {
                            this.user['mobile'] = input;
                          });
                        },
                        validator: (input) => input.length < 10
                            ? 'should be more than 10 digit'
                            : null,
                        decoration: InputDecoration(
                          labelText: 'Mobile',
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.phone,
                              color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (input) {
                          setState(() {
                            this.user['email'] = input;
                          });
                        },
                        validator: (input) => !input.contains('@')
                            ? 'should be a valid email'
                            : null,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'user@example.com',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.alternate_email,
                              color: Theme.of(context).accentColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: _hidePassword,
                        onChanged: (input) {
                          setState(() {
                            this.user['password'] = input;
                          });
                        },
                        validator: (input) => input.length < 6
                            ? 'Should be more than 6 letters'
                            : null,
                        decoration: InputDecoration(
                          labelText: 'password',
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: '••••••••••••',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.7)),
                          prefixIcon: Icon(Icons.lock_outline,
                              color: Theme.of(context).accentColor),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            color: Theme.of(context).focusColor,
                            icon:  _hidePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 20),
                      BlockButtonWidget(
                        text: Text(
                          'Register',
                          style:
                              TextStyle(color: Colors.white),
                        ),
                        color:  Colors.green,
                        onPressed: () {
                          register(userProvider);
                        },
                      ),
                      SizedBox(height: 25),
//                      FlatButton(
//                        onPressed: () {
//                          Navigator.of(context).pushNamed('/MobileVerification');
//                        },
//                        padding: EdgeInsets.symmetric(vertical: 14),
//                        color: Theme.of(context).accentColor.withOpacity(0.1),
//                        shape: StadiumBorder(),
//                        child: Text(
//                          'Register with Google',
//                          textAlign: TextAlign.start,
//                          style: TextStyle(
//                            color: Theme.of(context).accentColor,
//                          ),
//                        ),
//                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/Login');
                },
                textColor: Theme.of(context).hintColor,
                child: Text('I have account? Go to login'),
              ),
            )
          
          ],
        ),   
         
        
      ),
    );
  }

   void register(model) async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      await model.registerUser(user).then((value) {
        print(value);
        //&& value.apiToken != null
        if (value['status'] == true ) {
          SnackBar(
            content: Text('welcome to Lorrystand'),
          );
          Navigator.of(scaffoldKey.currentContext).pushReplacementNamed('/Login');
        } else {
          setState(() {
            _isLoading = false;
          });
          SnackBar(
            content: Text('S.current.wrong_email_or_password'),
          );
        }
      });
      // repository.register(user).then((value) {
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
