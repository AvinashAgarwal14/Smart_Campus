import 'package:flutter/material.dart';
import './ui/splash_screen/splash_screen.dart';
import './ui/home/home.dart';
import './ui/administrator/admin.dart';
import './ui/events/club1/club1_events.dart';
import './ui/events/club2/club2_events.dart';
import './ui/events/club3/club3_events.dart';
import './util/create_account.dart';

void main() {
  runApp(
      new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            canvasColor: Color.fromRGBO(180,180,180, 0.0),
            textTheme: TextTheme(

            )
        ),
        home: new SplashScreen(),
        initialRoute: "/ui/home",
        routes: <String, WidgetBuilder>{
          "/ui/home": (BuildContext context) => new HomePage(),
          "/ui/events/club1": (BuildContext context) => new Club1Events(),
          "/ui/events/club2": (BuildContext context) => new Club2Events(),
          "/ui/events/club3": (BuildContext context) => new Club3Events(),
          "/ui/admin": (BuildContext context) => new Admin(),
          "/createAccount": (BuildContext context) => new CreateAccount()
        },
      )
  );
}