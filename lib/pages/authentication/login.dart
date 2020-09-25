import 'package:berbera_2/pages/authentication/register.dart';
import 'package:berbera_2/pages/supplierMain.dart';
import 'package:berbera_2/services/auth.dart';
import 'package:berbera_2/widget/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _formChanged = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode focusNode;
  String _email = '';
  String _password = '';
  String _error = '';

  void _next_page() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.leftToRightWithFade,
            duration: Duration(milliseconds: 500),
            child: Register()));
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of(context).auth;

    return MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xffe9902e),
        ),
        home: Scaffold(
          /*
     appBar: AppBar(
     title: Text('Berbera', style: TextStyle(color: Colors.white),), centerTitle: true,
      backgroundColor: Colors.orange,
     actions: <Widget>[
        FlatButton.icon(
          icon : Icon(Icons.person,color:Colors.white),
          label : Text(
            'Register',
            style:TextStyle(color:Colors.white),
          ),
          onPressed: (){
            Navigator.of(context).pushReplacementNamed('/register');
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
                                'Berbera Market',
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

                                  hintText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.00),
                                    gapPadding: 5,
                                  ),

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
                                    borderRadius: BorderRadius.circular(12.00),
                                    gapPadding: 5,),

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
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: 50,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                    ),
                                    color: Color(0xffe9902e),
                                    child: Text("Sign in",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: _formChanged
                                        ? () async {
                                      if (_formKey.currentState.validate()) {
                                        dynamic result = await auth
                                            .signInWithEmailAndPassword(
                                            _email, _password);
                                        if (result == null) {
                                          setState(() =>
                                          _error =
                                          'Incorrect email address or password!');
                                        } else {
//                                Navigator.of(context).pushNamed(
//                                    '/supp');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SupplierMain(),
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
                                )
                            ),
                            SizedBox(height: 10.0),
                            Row(

                              children: [Text("Don't have an account?"), FlatButton(
                                onPressed: () {
                                  _next_page();
                                },
                                child: Text('Sign UP', style: TextStyle(
                                  color: Color(0xffe9902e),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),),)
                              ],),

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
        ));
  }

  void _onFormChange() {
    if (_formChanged) return;
    setState(() {
      _formChanged = true;
    });
  }
}
