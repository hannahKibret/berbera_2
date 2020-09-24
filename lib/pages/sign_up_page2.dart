import 'package:berbera_2/models/profile.dart';
import 'package:berbera_2/pages/sign_up_page3.dart';
import 'package:berbera_2/services/auth.dart';
import 'package:berbera_2/widget/bank_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:berbera_2/services/bankInfo_service.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:steps/steps.dart';
class SignupPage2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SignupPage2State();

}
class _SignupPage2State extends State<SignupPage2> {


  bool _formChanged = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode focusNode;
  Bank _bank = Bank();
  String _bankName = BankName[0];
  BankInfoService _createBank = BankInfoService();
  AuthService auth = AuthService();


  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    _bank.bankName = BankName[0];
  }

  // _SignupState({this.selectedLocation});


  @override
  Widget build(BuildContext context) {
    double height =  MediaQuery.of(context).size.height;
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(
        primaryColor: Colors.deepOrange,
    ),
      home:Scaffold(
      appBar: AppBar(
        title: Text('Berbera',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: _formKey,
          onChanged: _onFormChange,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                height:60.0,
                alignment: Alignment.topCenter,
                child:Center(

                  child:Steps(
                    direction: Axis.horizontal,
                    size: 11.0,
                    path: {'color': Colors.black, 'width': 2.0},
                    steps: [
                      {
                        'color': Colors.white,
                        'background': Colors.black,
                        'label': '1',

                      },
                      {
                        'color': Colors.white,
                        'background': Colors.deepOrange,
                        'label': '2',

                      },
                      {
                        'color': Colors.white,
                        'background': Colors.black,
                        'label': '3',

                      }
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child:Text(
                      'Payment Information',
                      style:TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,

                      )
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (String val) => this._bank.customer = val,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // helperText: "Required",
                    labelText: "Full name",
                  ),
                  autofocus: true,
                  autovalidate: _formChanged,
                  validator: (String val) {
                    if (val.isEmpty) return "Field cannot be left blank";
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (String val) => this._bank.bankAccount = val,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // helperText: "Required",
                    labelText: "Account No",
                  ),
                  autofocus: true,
                  //autovalidate: _formChanged,
                  validator: (String val) {
                    if (val.isEmpty) return "Field cannot be left blank";
                    return null;
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: BankDropDownField(
                  selectedBank: this._bankName,
                  onChanged:(newBank){setState((){
                   this. _bank.bankName = newBank;
                    this._bankName = newBank;
                  });},
                ),
              ),

              Divider(
                height: 32.0,
              ),
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right:5.0),
                      child: RaisedButton(
                        color: Colors.deepOrange,
                        child: Text("Next",
                          style:TextStyle(
                            color:Colors.white,
                          ),
                        ),
                        onPressed: _formChanged
                            ? () async{
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                           // navigateToSignupPage3(context);
                            final uid = await auth.getCurrentUID();
                            //Navigator.of(context).pushReplacementNamed('/signupage3');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context)=> SignupPage3(),
                                settings: RouteSettings(
                                    arguments: ''
                                ),
                              ),
                            );
                            Map<String,dynamic> bankData={'customer':this._bank.customer,'accountNo':this._bank.bankAccount,'bankName':this._bank.bankName};
                            _createBank.addData(bankData,uid);

                          } else {
                            FocusScope.of(context).requestFocus(focusNode);
                          }
                        }
                            : null,
                      ),
                    ),
                  ),
                ),
        ],
              ),

            ],
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

  Future navigateToSignupPage3(context) async {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
  }


}