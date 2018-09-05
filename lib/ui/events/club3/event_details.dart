import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:ui' as ui;
import '../model/event_data.dart';
import './edit_event.dart';

class EventDetails extends StatefulWidget {

  EventItem eventDetail;
  EventDetails({Key key, this.eventDetail}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
    databaseReference = database.reference().child("Club3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(widget.eventDetail.imageUrl, fit: BoxFit.cover),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: _buildContent(),
            ),
          ),
        ],
      ),
      floatingActionButton: (currentUser!=null && currentUser.uid == widget.eventDetail.adminId)?
      FloatingActionButton(
        backgroundColor: Colors.grey,
          child: Icon(Icons.edit) ,
          onPressed: _editEventData
      ):
          Container()
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 0.0) ,
                        title: Text(
                          widget.eventDetail.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                        trailing: (currentUser!=null && currentUser.uid == widget.eventDetail.adminId)?
                                    IconButton(icon: Icon(Icons.delete, color: Colors.redAccent,),
                                        onPressed: _deleteEvent)
                                    : null
                      ),
                      Text(
                        "Date: ${widget.eventDetail.date}",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontWeight: FontWeight.w500,
                            fontSize: 15.0
                        ),
                      ),
                      Text(
                        "Date: ${widget.eventDetail.venue}",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w500,
                            fontSize: 15.0
                        ),
                      ),
                      Container(
                        color: Colors.white.withOpacity(0.85),
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        width: 225.0,
                        height: 1.0,
                      ),
                      Text(
                        widget.eventDetail.body,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            height: 1.4,
                            fontSize: 15.0
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Future _getUser() async {

    FirebaseUser user = await _auth.currentUser();
    setState(() {
      currentUser = user;
    });
  }

  _deleteEvent()
  {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(

            title: new Text("Delete"),
            content: new Text("Are you sure you want to delete this event?"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Delete"),
                onPressed: () {
                  databaseReference.child(widget.eventDetail.key).remove();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
  }

  _editEventData()
  {
    Navigator.popUntil(context, ModalRoute.withName("/ui/events/club3"));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => new EditEvent(eventDetail: widget.eventDetail)),
    );
  }

}
