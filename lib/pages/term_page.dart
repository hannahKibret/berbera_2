import 'package:flutter/material.dart';

class TermPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Berbera',style: TextStyle(color: Colors.white),),
    backgroundColor: Colors.deepOrange,

    ),
       body:Container(
        width: MediaQuery.of(context).size.width - 25,
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'TERMS AND CONDITIONS',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'By reading the following terms and conditions you have understood, and agreed to be bounded by all of those terms of use.'
                  'Mentioned as follow; Provide accurate information from color to features and any information considered necessary. All'
                  ' registration info you submit are true, accurate, current and complete. And that you have agreed to keep your password'
                  ' confidential and will be responsible for all the used by your account. And impersonating other users is strictly forbidden.'
                  ' The monthly fee for retailers is 200 ETB as we accept the following forms of payment\n\t\t\t\t\t\t. CBE Birr\n\t\t\t\t\t\t. hallo cash\n\t\t\t\t\t\t'
                  ' . mobile banking and\n. in cash\nYou further agree to promptly update account and payment for all prices in ETB. And retailer found violating the terms will'
                  ' lose their account and can\'t use the Hulu service for unlimited period.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                )),
          ],
        ),
       ),

    );
  }

}