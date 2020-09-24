import 'package:berbera_2/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:berbera_2/widget/provider.dart';
import 'package:berbera_2/pages/supplierMain.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class  LoginPage extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider
        .of(context)
        .auth;

    return MaterialApp(
        theme: ThemeData(
        primaryColor: Colors.deepOrange,
    ),
      home:Scaffold(
     appBar: AppBar(
     title: Text('Berbera',style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.deepOrange,
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

      body: Builder(
        builder: (context) =>
            Container(

              padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 50.0),
              child: Form(
                key: _formKey,
                onChanged: _onFormChange,
                child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          //onSaved: (String val) => this._email = val,
                          onChanged: (String val) => this._email = val,
                          decoration: InputDecoration(

                            border: OutlineInputBorder(

                            ),
                            // helperText: "Required",
                            labelText: "Email",
                          ),
                          autofocus: true,
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
                            border: OutlineInputBorder(),
                            // helperText: "Optional",
                            labelText: "Password",
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
                        child: RaisedButton(
                          color:  Colors.deepOrange,
                          child: Text("Sign in",
                            style:TextStyle(
                              color:Colors.white,
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
                                    builder: (context)=> SupplierMain(),
                                    settings: RouteSettings(
                                        arguments: ''
                                    ),
                                  ),
                                );
                              }
                            } else {
                              FocusScope.of(context).requestFocus(focusNode);
                            }
                          }
                              : null,
                        ),
                      ),
                      SizedBox(height: 12.0),
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
    );
  }

  void _onFormChange() {
    if (_formChanged) return;
    setState(() {
      _formChanged = true;
    });
  }
}
