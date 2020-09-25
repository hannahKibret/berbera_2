
import 'package:flutter/material.dart';
import 'package:berbera_2/services/offer_service.dart';
import 'package:berbera_2/widget/offer_list.dart';

import 'offer_adding_page.dart';
class  Offers extends StatefulWidget {
  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<Offers> {
  OfferService _offerService = OfferService();
  OfferList _offerList = OfferList();

  @override
  Widget build(BuildContext context) {
    Stream stream = _offerService.getoffer(context);
    return
//      appBar: AppBar(
//        backgroundColor: Colors.black,
//        title: Text(
//          "Berbere",
//          style: TextStyle(color: Colors.white),
//        ),
//      ),
      StreamBuilder(
          stream : stream,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child:CircularProgressIndicator(),
              );
            }
            else if(!snapshot.hasData){
              return Center(
                child:Text('No offer added!'),
              );
            }
            return Container(
                child:Column(
                  children: <Widget>[
                Flexible(
                  child: ListView.separated(
                      separatorBuilder: (context, _) => Container(
                            height: 1,
                            color: Colors.black,
                            padding: EdgeInsetsDirectional.only(start: 72),
                            child: Container(
                              height: 1,
                              color: Colors.black,
                              width: double.infinity,
                            ),
                          ),
                      itemCount: snapshot.data.documents.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return _offerList.buildOfferList(
                            context, snapshot.data.documents[index]);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width - 25,
                      height: 50,
                      child: RaisedButton(
                        child: Text(
                          'Add offer',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                        color: Color(0xffe9902e),
                        onPressed: () {
//                        Navigator.of(context).pop();
//                        Navigator.of(context).pushReplacementNamed('/offerAdd');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OfferAddingPage(),
                              settings: RouteSettings(arguments: ''),
                            ),
                          );
                        },
                      )),
                )
              ]));

          }

    );
  }
}
