import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../model/event_data.dart';
import 'dart:ui' as ui;

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {

  FirebaseUser currentUser;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  EventItem event;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
    event = new EventItem("", "","","","","");
    databaseReference = database.reference().child("Club2");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("images/background.png", fit: BoxFit.cover),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: _buildContent(),
            ),
          ),
        ],
      ),
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
                  padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Create Event",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        ),
                      ),
                      Container(
                        color: Colors.white.withOpacity(0.85),
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        width: 225.0,
                        height: 1.0,
                      ),
                      TextFormField(
                        initialValue: '',
                        style: TextStyle(color: Colors.white),
                        onSaved: (val)=> event.title = val,
                        validator: (val)=> val == ""? val : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          errorStyle: TextStyle(color: Colors.red),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "Title",
                        ),
                      ),
                      TextFormField(
                        initialValue: '',
                        style: TextStyle(color: Colors.white),
                        onSaved: (val)=> event.date = val,
                        validator: (val)=> val == ""? val : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          errorStyle: TextStyle(color: Colors.red),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "Date",
                        ),
                      ), TextFormField(
                        initialValue: '',
                        style: TextStyle(color: Colors.white),
                        onSaved: (val)=> event.venue = val,
                        validator: (val)=> val == ""? val : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          errorStyle: TextStyle(color: Colors.red),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "Venue",
                        ),
                      ), TextFormField(
                        initialValue: '',
                        style: TextStyle(color: Colors.white),
                        onSaved: (val)=> event.body = val,
                        validator: (val)=> val == ""? val : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          errorStyle: TextStyle(color: Colors.red),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "Body",
                        ),
                      ),
                      TextFormField(
                        initialValue: '',
                        style: TextStyle(color: Colors.white),
                        onSaved: (val)=> event.imageUrl = val,
                        validator: (val)=> val == ""? val : null,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          errorStyle: TextStyle(color: Colors.red),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: "ImageUrl",
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10.0),) ,
                      RaisedButton(
                          child: Text("Create"),
                          onPressed: () {
                            _writeToDatabase();
//                      HomePage();
                          })
                    ],
                  )
              )
              )
            ]
        )
    );
  }

    Future _getUser() async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      setState(() {
        currentUser = user;
      });
    }

    _writeToDatabase()
    {
      event.adminId = currentUser.uid;
      final FormState form = formKey.currentState;
      if(form.validate())
      {
        form.save();
        form.reset();
        //Save form data to the database
        databaseReference.push().set(event.toJson());
      }
      Navigator.of(context).pop();
    }
}
