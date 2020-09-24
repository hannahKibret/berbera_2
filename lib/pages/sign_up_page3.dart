import 'package:berbera_2/pages/supplierMain.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:steps/steps.dart';

class SignupPage3 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SignupPage3State();

}
class _SignupPage3State extends State<SignupPage3> {





  @override
  Widget build(BuildContext context) {
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
      body: Center(
        //width:MediaQuery.of(context).size.width,
        child:Column(

          children:<Widget>[

            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
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
                      'background': Colors.black,
                      'label': '2',

                    },
                    {
                      'color': Colors.white,
                      'background': Colors.deepOrange,
                      'label': '3',

                    }
                  ],
                ),
              ),

            ),


           Text(
              'TERMS AND CONDITIONS',
              style: TextStyle(
                color: Colors.red[600],
                fontWeight: FontWeight.bold,
              ),
             textAlign:TextAlign.center,


    ),



          Text(
            'By reading the following terms and conditions you have understood, and agreed to be bounded by all of those terms of use.'
                'Mentioned as follow; Provide accurate information from color to features and any information considered necessary. All'
                ' registration info you submit are true, accurate, current and complete. And that you have agreed to keep your password'
                ' confidential and will be responsible for all the used by your account. And impersonating other users is strictly forbidden.'
                ' The monthly fee for retailers is 200 ETB as we accept the following forms of payment\n\t\t\t\t\t\t. CBE Birr\n\t\t\t\t\t\t. hallo cash\n\t\t\t\t\t\t'
                ' . mobile banking and\n. in cash\nYou further agree to promptly update account and payment for all prices in ETB. And retailer found violating the terms will'
                ' lose their account and can\'t use the Hulu service for unlimited period.',
            style:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
            ),
            textAlign:TextAlign.center,
            softWrap:true,

        ),

        Flex(
          direction: Axis.horizontal,
          children:<Widget>[ Expanded(
            child: Align(
                alignment: Alignment.bottomRight,


                child: Padding(
                  padding: const EdgeInsets.only(right:5.0),
                  child: RaisedButton(

                    color:Colors.deepOrange,
                    child: Text("Finish",
                      style:TextStyle(
                        color:Colors.white,
                      ),
                    ),
                    onPressed: (){
                      // Navigator.of(context).pop();
                      //Navigator.of(context).pushReplacementNamed('/supp');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=> SupplierMain(),
                          settings: RouteSettings(
                              arguments: ''
                          ),
                        ),
                      );
                    },
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
    );
  }




}