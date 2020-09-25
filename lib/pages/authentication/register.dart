import 'dart:math';

import 'package:berbera_2/pages/authentication/login.dart';
import 'package:berbera_2/services/auth.dart';
import 'package:berbera_2/services/verification_service.dart';
import 'package:berbera_2/widget/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../sign_up_page.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _formChanged = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode focusNode;
  String _email = '';
  String _password = '';
  String _error = '';

  VerificationService _vService = VerificationService();

  void _next_page() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            duration: Duration(milliseconds: 500),
            child: LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of(context).auth;

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: Scaffold(
        /*    appBar:AppBar(
        title: Text('Berbera',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
        actions: <Widget>[
          FlatButton.icon(
            icon : Icon(Icons.person,color:Colors.white),
            label : Text(
              'Sign in',
              style:TextStyle(color:Colors.white),
            ),
            onPressed: (){
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
*/
        body: Builder(
          builder: (context) =>
              Container(
                padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  onChanged: _onFormChange,
                  child: Center(
                    child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Image(image: AssetImage('images/logo.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Welcom to Berbera',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 30,
                                letterSpacing: -0.384,
                                fontWeight: FontWeight.w700,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              //onSaved: (String val) => this._email = val,
                              onChanged: (String val) => this._email = val,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.00),),
                                // helperText: "Required",
                                hintText: "Email",
                              ),
                              autovalidate: _formChanged,
                              validator: (String val) {
                                if (val.isEmpty)
                                  return "Enter an email";
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              focusNode: focusNode,
                              obscureText: true,
                              onChanged: (String val) => this._password = val,
                              //onSaved: (String val) => this._store.storeName = val,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.00),),
                                // helperText: "Optional",
                                hintText: "Password",
                              ),
                              validator: (String val) {
                                if (val.length < 8) {
                                  return "Enter a password 8+ char long";
                                }
                                return null;
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              focusNode: focusNode,
                              obscureText: true,
                              onChanged: (String val) => this._password = val,
                              //onSaved: (String val) => this._store.storeName = val,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.00),),

                                // helperText: "Optional",
                                hintText: "Confirm Password",
                              ),
                              /*    validator: (String val) {
                                if (val.length < 8) {
                                  return "Enter a password 8+ char long";
                                }
                                return null;
                              },*/
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 10),
                            child: Container(
                              height: 50,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                                color: Color(0xffe9902e),
                                child: Text("Sign Up",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: _formChanged
                                    ? () async {
                                  if (_formKey.currentState.validate()) {
                                    dynamic result = await auth
                                        .registerWithEmailAndPassword(
                                        _email, _password);
//                                Map<String,dynamic> emailData = {'email':_email};
//                                _vService.addRequest(emailData);emailData
                                    Random random = new Random();
                                    int randomNum = random.nextInt(100000) +
                                        10000;
                                    Map<String, dynamic> codeData = {
                                      'code': randomNum.toString()
                                    };
                                    _vService.addCode(_email, codeData);
                                    if (result == null) {
                                      setState(() =>
                                      _error =
                                      'Please enter a valid email address!');
                                    } else {
//                                  Navigator.of(context).pop();
//                                  Navigator.of(context).pushReplacementNamed(
//                                      '/signupage1');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignupPage(),
                                          settings: RouteSettings(
                                              arguments: ''
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    FocusScope.of(context).requestFocus(
                                        focusNode);
                                  }
                                }
                                    : null,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text('Already have an account?'),
                              FlatButton(onPressed: () {
                                _next_page();
                              },
                                  child: Text('Sign In',
                                    style: TextStyle(
                                        color: Color(0xffe9902e),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),))
                            ],
                          ),
                          Text(
                            _error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ]


                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }


  void _onFormChange() {
    if (_formChanged) return;
    setState(() {
      _formChanged = true;
    });
  }
}
