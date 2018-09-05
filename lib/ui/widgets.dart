import 'package:flutter/material.dart';

class Widgets extends StatefulWidget {
  @override
  _WidgetsState createState() => _WidgetsState();
}

class _WidgetsState extends State<Widgets> {
  Icon menuIcon(IconData abc) {
    return new Icon(
      abc,
      color: Colors.white,
      size: 18.0,
    );
  }

  final menuData = new TextStyle(
    fontSize: 18.0,
    fontFamily: 'roboto',
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          Padding(padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0)),
          new Center(
              child: new ListTile(
                  title: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Image.asset("images/logo.png"),
                    radius: 45.0,
                  ),
                  subtitle: new Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Text(
                      "Smart Campus",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ))),

          new ListTile(
              leading: menuIcon(Icons.dashboard),
              title: new Text(
                "Dashboard",
                style: menuData,
              ),
              trailing: menuIcon(Icons.navigate_next),
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/ui/home'));
                Navigator.of(context).pushNamed("/ui/home");
              }),

          new ListTile(
            leading: menuIcon(Icons.event),
            title: new Text(
              "Club1 Events",
              style: menuData,
            ),
            trailing: menuIcon(Icons.navigate_next),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/ui/home'));
              Navigator.of(context).pushNamed("/ui/events/club1");
            },
          ),
          new ListTile(
              leading: menuIcon(Icons.event),
              title: new Text(
                "Club2 Events",
                style: menuData,
              ),
              trailing: menuIcon(Icons.navigate_next),
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/ui/home'));
                Navigator.of(context).pushNamed("/ui/events/club2");
              }),

          new ListTile(
              leading: menuIcon(Icons.event),
              title: new Text(
                "Club3 Events",
                style: menuData,
              ),
              trailing: menuIcon(Icons.navigate_next),
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/ui/home'));
                Navigator.of(context).pushNamed("/ui/events/club3");
              }),

          new ListTile(
              leading: menuIcon(Icons.person),
              title: new Text(
                "Administrators Login",
                style: menuData,
              ),
              trailing: menuIcon(Icons.navigate_next),
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/ui/home'));
                Navigator.of(context).pushNamed("/ui/admin");
              }),
        ],
      ),
      elevation: 1.0,
    );
  }
}
