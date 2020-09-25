import 'package:berbera_2/pages/authentication/login.dart';
import 'package:berbera_2/pages/authentication/register.dart';
import 'package:berbera_2/pages/edit_account_page.dart';
import 'package:berbera_2/pages/new_page.dart';
import 'package:berbera_2/pages/offer_adding_page.dart';
import 'package:berbera_2/pages/offer_page.dart';
import 'package:berbera_2/pages/order_page.dart';
import 'package:berbera_2/pages/sign_up_page.dart';
import 'package:berbera_2/pages/sign_up_page2.dart';
import 'package:berbera_2/pages/sign_up_page3.dart';
import 'package:berbera_2/pages/supplierMain.dart';
import 'package:berbera_2/pages/term_page.dart';
import 'package:berbera_2/services/auth.dart';
import 'package:berbera_2/widget/provider.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: 'Berbera',
        theme: ThemeData(
          appBarTheme:
              new AppBarTheme(color: Color(0xfff8b250), centerTitle: true),
          primarySwatch: Colors.deepOrange,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/register': (BuildContext context) => new HomeController(),
          '/login': (BuildContext context) => new LoginPage(),
          '/signupage1': (BuildContext context) => new SignupPage(),
          '/signupage2': (BuildContext context) => new SignupPage2(),
          '/signupage3': (BuildContext context) => new SignupPage3(),
          '/orders': (BuildContext context) => new Orders(),
          '/edit': (BuildContext context) => new EditAccountPage(),
          '/offerAdd': (BuildContext context) => new OfferAddingPage(),
          '/offer': (BuildContext context) => new Offers(),
          '/term': (BuildContext context) => new TermPage(),
          '/new': (BuildContext context) => new NewPage(),
          '/supp': (BuildContext context) => new SupplierMain(),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;

    // TODO: implement build
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return Register();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
