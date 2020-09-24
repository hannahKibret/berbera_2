
import 'package:berbera_2/services/order_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderCarousel {
  OrderService _orderService = OrderService();

  bool _isVis = false;
  Widget buildOrderCarousel(BuildContext context,Function changeVisibility) {

    Stream stream = _orderService.getOrder(context);

    // TODO: implement build
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child:CircularProgressIndicator(),
          );
        }
        else if(!snapshot.hasData){
          return Text(
            ''
          );
        }
        return CarouselSlider(
          //height: 185.0,
          //viewportFraction: 1.00,

          items: snapshot.data.documents.map<Widget>((order) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                 width: MediaQuery.of(context).size.width,

                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  decoration: BoxDecoration(
                      color:Colors.deepOrange,
                  ),
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
                                imageUrl: order['image'],
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
                  (_isVis)?Text(order['customerName'],
                                style:TextStyle(
                                  fontSize: 12.0,
                                ) ,

                              ):Text(''),

//                Text(order.rate.toString()),
                            (_isVis)?Padding(
                              padding:new EdgeInsets.only(bottom: 10.0),
                              child:RatingBar(
                                initialRating:double.parse(order['rate']),
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

                            Text(
                              order['productName'],
                              textAlign: TextAlign.left,
                            ),
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
              },
            );
          }).toList(),
        );
      }
    );
  }

}