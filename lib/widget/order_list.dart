import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:berbera_2/models/order.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderList  {
  bool isVisible;
  Order order;
  BuildContext context;
  Function changeVisibility;
  //String _downloadURL;
 // OrderList({this.context,this.changeVisibility});


 //OrderList(this.isVisible,this.changeVisibility);
//  Future downloadImage(String filename) async{
//    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
//    String downloadAddress = await firebaseStorageRef.getDownloadURL();
//  _downloadURL = downloadAddress;
//
//  }
 bool _isVis = false;

  @override
  Widget buildOrder(BuildContext context,DocumentSnapshot order, changeVisibility) {

    // TODO: implement build
    return new Container(
      child:Card(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget>[
                Padding(
                  padding:new EdgeInsets.only(left:30.0,right:10.0),
                  child:(order['image'] != null)?CachedNetworkImage(
                   imageUrl:order['image'],
                    placeholder:(context,url)=>CircularProgressIndicator(),
                    width:100.0,
                    height: 125.0,

                  ):null,
                ),
                Text(
                  order['progress'],
                  style:TextStyle(
                    fontSize: 12.0,
                  ) ,
                ),

                //  visible: order.isVisible,
                (_isVis)?Text(order['customerName'],
                    style:TextStyle(
                      fontSize: 12.0,


                  ),
                ):Text(''),
//                Text(order.rate.toString()),
                (_isVis)?Padding(
                  padding:new EdgeInsets.only(bottom: 10.0),
                  child:RatingBar(
                    initialRating: double.parse(order['rate']),
                    minRating: 1,
                    itemSize: 12.0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
//          onRatingUpdate: (rating) {
//            print(rating);
//          },
                  ),
                ):Text(''),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[

                Text(order['productName'],
                  textAlign: TextAlign.left,),
                Text(order['price']),
                Text(order['size']),
                Text('Delivery Code:- ${order['deliveryCode']}'),
                Text('payment:- ${order['payment']}'),
                GestureDetector(
                  onTap:()=>_isVis = changeVisibility(),

                  child:Text(
                    'Customer Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }


}

