import 'package:berbera_2/pages/term_page.dart';
import 'package:berbera_2/services/supplier_service.dart';
import 'package:flutter/material.dart';
//import 'package:carousel_pro/carousel_pro.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './home.dart';
import './inventory.dart';
import './new_page.dart';
import './order_page.dart';
import './offer_page.dart';
import './payment.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'edit_account_page.dart';
void main() => runApp(SupplierMain());
class SupplierMain extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _SupplierMainState createState() => _SupplierMainState();
}

class _SupplierMainState extends State<SupplierMain> {
  SupplierService createProfile = SupplierService();
  String _image;
  bool isNull = false;
  int _selectedPage = 0;
  final _page = [
    Home(),
    Orders(),
    Inventory(),
    Payment(),
    Offers(),
  ];
  @override
  Widget build(BuildContext context) {
    Stream stream = createProfile.getSupplier(context).asBroadcastStream();
    return  MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(_page[_selectedPage].toString()),
          backgroundColor: Colors.grey[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          child: _page[_selectedPage],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedPage,
          onTap: (int index){
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Orders'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              title: Text('Inventory'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              title: Text('Payment'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.loyalty),
              title: Text('Offers'),
            ),
          ],
        ),
        drawer: StreamBuilder(

          stream: stream,
          builder: (context, snapshot) {
            //_image = snapshot.data.documents[0]['image'];
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child:CircularProgressIndicator(),
              );
            }else if(!snapshot.hasData){
              isNull = true;
            }
            if(isNull){
              _image = null;
            }else{
              _image = snapshot.data.documents[0]['image'];
            }

            return Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: (isNull)?Text('Store Name'):Text(snapshot.data.documents[0]['storename']??''),
                    accountEmail: (isNull)?Text('By: Supplier Name'):Text('By:${ snapshot.data.documents[0]['fullname']??''}'),
                    currentAccountPicture: GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
//                                backgroundColor:Colors.black,
                                    child:ClipOval(
                                      child:SizedBox(
                                        width:100.0,
                                        height:100.0,

                                        child:(_image != null)? CachedNetworkImage(imageUrl:_image,placeholder:(context,url)=>CircularProgressIndicator(),fit: BoxFit.fill):Icon(
                            Icons.person,
                            color: Colors.black,
                          ),

                                      ),
                                      ),

                                    ),
//                      child: Icon(
//                        Icons.person,
//                        color: Colors.black,
//                      ),
                        ),

                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      //Navigator.pop(context);
                     // Navigator.of(context).pushNamed('/edit');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=> EditAccountPage(),
                          settings: RouteSettings(
                              arguments: ''
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text('My Account'),
                      leading: Icon(Icons.account_circle, color: Colors.deepOrangeAccent,),
                    ),
                  ),
                  InkWell(
                    onTap: (){},
                    child: ListTile(
                      title: Text('Rate Us'),
                      leading: Icon(Icons.rate_review, color: Colors.deepOrange,),
                    ),
                  ),
                  InkWell(
                    onTap: (){},
                    child: ListTile(
                      title: Text('Language'),
                      leading: Icon(Icons.language, color: Colors.deepOrange,),
                    ),
                  ),
                  InkWell(
                    onTap: (){},
                    child: ListTile(
                      title: Text('Feedback'),
                      leading: Icon(Icons.feedback, color: Colors.deepOrange,),
                    ),
                  ),
                  Divider(),
                  InkWell(
                    onTap: (){
//                      Navigator.pop(context);
//                      Navigator.of(context).pushNamed('/term');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=> TermPage(),
                          settings: RouteSettings(
                              arguments: ''
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text('Terms and Conditions'),
                      leading: Icon(Icons.assignment, color: Colors.red,),
                    ),
                  ),
                  InkWell(
                    child: ListTile(
                      title: Text('About'),
                      leading: Icon(Icons.help, color: Colors.red,),
                      onTap: () {
//                        Navigator.pop(context);
//                        Navigator.of(context).pushNamed('/new');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context)=> NewPage(),
                            settings: RouteSettings(
                                arguments: ''
                            ),
                          ),
                        );

                    },
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

