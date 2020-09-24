import 'package:berbera_2/pages/offer_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:berbera_2/services/offer_service.dart';

class OfferList {
  OfferService _offerService = OfferService();


  Widget buildOfferList(BuildContext context, DocumentSnapshot offer) {
    final uid = offer.documentID;

      return new Container(
        child: Center(
          child:Column(
            children: <Widget>[
              Align(
                alignment:Alignment.topRight,
                child: FlatButton.icon(
                  icon:Icon(Icons.close),
                  label:Text('remove'),
                  onPressed: (){
                     _offerService.deleteOffer(context, uid);
                  },
                ),
              ),
              Text(offer['name']),
              Padding(
                padding:const EdgeInsets.only(top:2.0,bottom:2.0),
              child:(offer['image'] != null)?CachedNetworkImage(
                imageUrl:offer['image'],
                placeholder:(context,url)=>CircularProgressIndicator(),
                width:100.0,
                height: 125.0,

              ):null,
              ),
              Text(offer['type']),

            ],
          )
        )
      );

  }
}