import 'dart:async';
import 'package:flutter/material.dart';
import './club1_events_page_item.dart';
import '../model/events_page_transformer.dart';
import 'club1_events.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../widgets.dart';
import './create_new_event.dart';

class UpcomingEventView extends StatefulWidget {
  @override
  _UpcomingEventViewState createState() => _UpcomingEventViewState();
}

class _UpcomingEventViewState extends State<UpcomingEventView> {

  String reqUserId;
  final GlobalKey<ScaffoldState> _appBarKey = new GlobalKey<ScaffoldState>();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  FirebaseUser currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseReference = database.reference().child("Club1_admin");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _appBarKey,
      drawer: new Widgets(),
      body: Stack(
        children: <Widget>[
          Center(
            child: SizedBox.fromSize(
                size: const Size.fromHeight(500.0),
                child: (eventsList.length != 0)
                    ? PageTransformer(
                  pageViewBuilder: (context, visibilityResolver) {
                    return PageView.builder(
                      controller: PageController(viewportFraction: 0.90),
                      itemCount: sampleItems.length,
                      itemBuilder: (context, index) {
                        final item = sampleItems[index];
                        final pageVisibility =
                        visibilityResolver.resolvePageVisibility(index);

                        return UpcomingEventItem(
                          item: item,
                          pageVisibility: pageVisibility,
                        );
                      },
                    );
                  },
                )
                    : new Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 200.0),
                      child: Text(
                        "No Upcomung Events. \n Tune in for Updates!",
                        style: new TextStyle(
                            fontSize: 20.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                )),
          ),
          Container (
              margin: EdgeInsets.fromLTRB(4.0, 28.0, 0.0, 0.0),
              child: new IconButton(
                icon: Icon(Icons.menu)
                ,
                color: Colors.white,
                onPressed: () => _appBarKey.currentState.openDrawer(),
              )
          )
        ],
      ),
      floatingActionButton: (currentUser!=null && (currentUser.uid==reqUserId))?
          FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.grey,
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new CreateEvent()),
                );
              }
          )
          :Container()
    );
  }

  Future _getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      currentUser = user;
    });
  }

  void _onEntryAdded(Event event) {
    setState(() {
      reqUserId = event.snapshot.value;
    });

  }
}
