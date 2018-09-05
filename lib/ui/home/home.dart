import 'package:flutter/material.dart';
import '../widgets.dart';
import './home_page_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Widgets(),
      body: HomePageContent(),

    );
  }

  Widget HomePageContent(){
    
    return new Stack(
        children: <Widget> [
          new Container(
            decoration: new BoxDecoration(
            image: new DecorationImage(
            image: new AssetImage("images/background.png"),
              fit: BoxFit.cover
              ),
            ),
          ),

          new HomePageView(),

    ],
    );
  }
}

