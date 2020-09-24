import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:berbera_2/models/order.dart';
import 'package:berbera_2/widget/order_list.dart';
import 'package:berbera_2/widget/order_carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:berbera_2/models/order.dart';
import 'package:berbera_2/services/supplier_service.dart';
import 'package:berbera_2/services/order_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Orders extends StatefulWidget{
  @override
 _OrderPageState createState() => _OrderPageState();

}

class _OrderPageState extends State<Orders>{
  OrderList _orderLst = OrderList();
  OrderCarousel _orderCarousel = OrderCarousel();
  SupplierService createProfile = SupplierService();
  OrderService _orderService = OrderService();
  String _downloadURL;
  String _downloadURLL;
  String _image;
  Order order;
  bool _isVis = false;
  int _order;


//  Future downloadImage(String filename) async{
//    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
//    String downloadAddress = await firebaseStorageRef.getDownloadURL();
//    setState(() => _downloadURL = downloadAddress);
//
//  }
//
//  Future<String> downloadImagee(String filename) async{
//    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(filename);
//    String downloadAddress = await firebaseStorageRef.getDownloadURL();
//    setState(() => _downloadURLL = downloadAddress);
//
//
//  }

  bool changeVisibility(){
    setState(() => _isVis = !_isVis);
    return _isVis;

  }
  @override
  Widget build(BuildContext context) {
    Stream stream = createProfile.getSupplier(context);
    Stream stream2 = _orderService.getOrder(context);
    // TODO: implement build
    return

//        appBar: AppBar(
//          backgroundColor: Colors.black,
//          title: Text(
//          "Berbera",
//          style: TextStyle(color: Colors.white),
//           ),
//          actions: <Widget>[
//            FlatButton.icon(
//              icon : Icon(Icons.shopping_cart,color:Colors.white),
//              label : Text(
//                'Offer',
//                style:TextStyle(color:Colors.white),
//              ),
//              onPressed: (){
//                Navigator.of(context).pushNamed('/offer');
//              },
//            )
//          ]
//    ),
     StreamBuilder(
        stream: stream2,
        builder: (context, snap) {

          if(snap.connectionState == ConnectionState.waiting){
            return Center(
              child:CircularProgressIndicator(),
            );
          }
          else if(snap.data.documents.length == 0){
            return Center(
              child:Center(
                child:Text('No orders yet'),
              ),
            );
          }
          return Container(
          child:Column(
          children:<Widget>[
            _orderCarousel.buildOrderCarousel(context,changeVisibility),

            Flexible(
            child:ListView.separated(
                separatorBuilder:  (context, _) => Container(
                  height: 1,
                  color: Colors.black,
                  padding: EdgeInsetsDirectional.only(start: 72),
                  child: Container(height: 1, color:Colors.black,width: double.infinity,),
                ),
              itemCount: snap.data.documents.length,
                scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index){
                 // downloadImagee(snap.data.documents[index]['image']);
                  return _orderLst.buildOrder(context, snap.data.documents[index],changeVisibility);}


          ),
            ),
            FlatButton(
              child:Text('check all delivered'),
              onPressed: (){
                _orderService.checkDelivered(context);
              },
            ),
          ]

    ),
    );
        }

//        drawer: Theme(
//    data: Theme.of(context).copyWith(
//    // Set the transparency here
//    canvasColor: Colors.transparent.withOpacity(0.3), //or any other color you want. e.g Colors.blue.withOpacity(0.5)
//    ),
//        child:Drawer(
//
//
//
//              child: ListView(
//
//                padding: EdgeInsets.zero,
//
//                children: <Widget>[
//                  StreamBuilder(
//                    stream: stream.asBroadcastStream(),
//                    builder: (context, snapshot) {
//                      if(snapshot.data == null){
//                        return DrawerHeader(
//                          child:CircularProgressIndicator(),
//
//                          decoration: BoxDecoration(
//                            // color: Colors.transparent,
//                          ),
//                        );
//                      }
//                      _image = snapshot.data.documents[0]['image'];
//                    //  downloadImage(_image);
//                      return DrawerHeader(
//                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children:<Widget>[
//                            Align(
//                              alignment: Alignment.center,
//                              child:CircleAvatar(
//                                radius: 50,
//                                backgroundColor:Colors.black,
//                                child:ClipOval(
//                                  child:SizedBox(
//                                    width:100.0,
//                                    height:100.0,
//
//                                    child:(_image != null)? CachedNetworkImage(imageUrl:_image,placeholder:(context,url)=>CircularProgressIndicator(),fit: BoxFit.fill):Image.asset(
//                                    'assets/images/profile_img.jpg',
//                                    fit: BoxFit.fill,
//                                  ),
//                                  ),
//
//                                ),
//                              ),
//                            ),
//                            Text(
//                                snapshot.data.documents[0]['storename'],
//                              style:TextStyle(color:Colors.white),
//                            ),
//                            Text(
//                                'By: ${snapshot.data.documents[0]['fullname']}',
//                              style:TextStyle(color:Colors.white),
//                            ),
//                          ]
//                        ),
//                        decoration: BoxDecoration(
//                         // color: Colors.transparent,
//                        ),
//                      );
//                    }
//                  ),
//                  ListTile(
//                    title: Text(
//                        'My account',
//                        style:TextStyle(color:Colors.white),
//                  ),
//                    onTap: () {
//                      // Update the state of the app
//                      // ...
//                      // Then close the drawer
//                      Navigator.pop(context);
//                      Navigator.of(context).pushNamed('/edit');
//                    },
//                  ),
//                  ListTile(
//                    title: Text(
//                        'Rate us',
//                        style:TextStyle(color:Colors.white),
//                    ),
//                    onTap: () {
//                      // Update the state of the app
//                      // ...
//                      // Then close the drawer
//                      Navigator.pop(context);
//                    },
//                  ),
//                  ListTile(
//                    title: Text(
//                        'Change Language',
//                      style:TextStyle(color:Colors.white),
//                    ),
//                    onTap: () {
//                      // Update the state of the app
//                      // ...
//                      // Then close the drawer
//                      Navigator.pop(context);
//                    },
//                  ),
//                  ListTile(
//                    title: Text(
//                        'terms and conditions',
//                      style:TextStyle(color:Colors.white),
//                    ),
//                    onTap: () {
//                      // Update the state of the app
//                      // ...
//                      // Then close the drawer
//                      Navigator.pop(context);
//                      Navigator.of(context).pushNamed('/term');
//                    },
//                  ),
//                  ListTile(
//                    title: Text(
//                        'updates',
//                      style:TextStyle(color:Colors.white),
//                    ),
//                    onTap: () {
//                      // Update the state of the app
//                      // ...
//                      // Then close the drawer
//                      Navigator.pop(context);
//                    },
//                  ),
//                  ListTile(
//                    title: Text(
//                      'new',
//                      style:TextStyle(color:Colors.white),
//                    ),
//                    onTap: () {
//                      // Update the state of the app
//                      // ...
//                      // Then close the drawer
//                      Navigator.pop(context);
//                      Navigator.of(context).pushNamed('/new');
//                    },
//                  ),
//                ],
//              ),
//
//
//        ),
//        ),
      );
  }




}