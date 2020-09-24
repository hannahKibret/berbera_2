import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class NewPage extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        title: Text('Berbera',style: TextStyle(color: Colors.white),),
    backgroundColor: Colors.grey[900],

    ),
     body:Container(
          width:MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:5.0,top:15.0,right:5.0,bottom: 15.0),

              child: Text('Berbera providing you with a personalized store front billboard to help you create larger customer exposure contact our customer service for more contact'),

            ),
            Divider(
              height:2.0,
              thickness: 1.0,
              color:Colors.deepOrange,

            ),
            Padding(
              padding: const EdgeInsets.only(left:5.0,top:15.0,right:5.0,bottom: 15.0),

              child: Text('The current market is all about making customer want the item by making it look important, we have some psychological marketing training organized to help you get more than you do today'),

            ),
            Divider(
              height:2.0,
              thickness: 1.0,
              color:Colors.deepOrange,

            ),
          ]
        )

     ),
    );
  }
}