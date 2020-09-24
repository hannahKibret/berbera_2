import 'package:flutter/material.dart';
import 'package:berbera_2/services/verification_service.dart';
import 'package:url_launcher/url_launcher.dart';

class  Validation extends StatefulWidget {
  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  List<String> emails = ['hanan','ahlam','bita'];
  List<String> codes = ['0000','0001','0002'];
  VerificationService _verificationService = VerificationService();
  String _email;
  String _subject = 'Berbera';
  String _body;


  void sendEmail(String url) async{
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {

    Stream stream2 = _verificationService.getCode(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Berbere",
            style: TextStyle(color: Colors.white),
          ),
        ),

      body: Container(
        padding : const EdgeInsets.all(8.0),

           child:StreamBuilder<dynamic>(
             stream: stream2,
             builder: (context, snapshot) {
               return Flex(
                 direction:Axis.vertical,
                children:<Widget>[
                  Flexible(

                      child:ListView.separated(
                        shrinkWrap: true,


                          separatorBuilder:(context, _) => Container(
                            height: 1,
                            color: Colors.black,
                            padding: EdgeInsetsDirectional.only(start: 72),
                            child: Container(height: 1, color:Colors.black,width: double.infinity,),
                          ),
                          itemCount: snapshot.data.documents.length??0,
                          itemBuilder: (BuildContext context, int index){
                          _email = snapshot.data.documents[index].documentID;
                          _body =  snapshot.data.documents[index]['code']??'';

                            return  Column(
                              children:<Widget>[
                                Text(_email??''),
                                Row(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Text('Approve'),
                                      onPressed:(){
                                        String url = 'mailto:' + snapshot.data.documents[index].documentID + '?subject=' + _subject + '&body=' + snapshot.data.documents[index]['code'];
                                        sendEmail(url);
                                        Map<String,dynamic> sentData = {'code':_body};
                                        _verificationService.addSent(_email, sentData);
                                        _verificationService.deleteVer(context, _email);


                                      }
                                  ),
                                  FlatButton(
                                      child:Text('Disapprove'),
                                      onPressed: (){
                                        _verificationService.deleteVer(context, _email);

                                      }
                                  ),
                                  ],
                                ),

                              ],
                          );
                          }
                      ),

                  ),
               ],
               );
             }
           ),

    ),

    );
  }
}
