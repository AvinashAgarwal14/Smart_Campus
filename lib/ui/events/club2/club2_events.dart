import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../model/event_data.dart';
import './club2_events_page_view.dart';

List<EventItem> eventsList;

class Club2Events extends StatefulWidget {
  @override
  _Club2EventsState createState() => _Club2EventsState();
}

class _Club2EventsState extends State<Club2Events> {

  EventItem event;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();

      eventsList = new List();
      event = new EventItem("", "", "", "","","");
      databaseReference = database.reference().child("Club2");
      databaseReference.onChildAdded.listen(_onEntryAdded);
      databaseReference.onChildChanged.listen(_onEntryChanged);
      databaseReference.onChildRemoved.listen(_onEntryRemoved);
    }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Container(
          child: (eventsList.length!=0)?
            new UpcomingEventView():
            new Center(
              child: Stack(
                children: <Widget>[
                  new Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                                const Color(0xFF000000),
                                const Color(0x00000000),
                              ],
                            ),
                          )
                    ),
                  Center(
                    child: new Container(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                ],
              )
          )
        )
      ]
    );
  }

  void _onEntryAdded(Event event) {

    setState(() {
      eventsList.add(EventItem.fromSnapshot(event.snapshot));
    });

  }


  void _onEntryChanged(Event event) {
    var oldEntry = eventsList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      eventsList[eventsList.indexOf(oldEntry)] = EventItem.fromSnapshot(event.snapshot);
    });

  }

  void _onEntryRemoved(Event event)
  {
    print(event.snapshot.value);
    var oldEntry = eventsList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    eventsList.removeAt(eventsList.indexOf(oldEntry));
  }

}
