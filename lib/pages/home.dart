import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

void main() => runApp(Home());

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200,
      child: Carousel(
        boxFit: BoxFit.fill,
        images: [
          AssetImage('images/img1.jpg'),
          AssetImage('images/img2.jpg'),
          AssetImage('images/img3.jpg'),
          AssetImage('images/img4.jpg'),
          AssetImage('images/img5.jpg'),
        ],
        autoplay: true,
        dotSize: 4.0,
        indicatorBgPadding: 7.0,
        //animationCurve: Curves.fastOutSlowIn,
        //animationDuration: Duration(milliseconds: 1000),
      ),
    );
    // TODO: implement build
    return ListView(
      children: <Widget>[
        image_carousel,
      ],
    );
  }

}