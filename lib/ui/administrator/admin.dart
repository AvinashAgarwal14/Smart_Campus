import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser currentUser;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  child: (currentUser==null)?
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Login",
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
                            style: TextStyle(color: Colors.white),
                            controller: _emailController,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              labelStyle: TextStyle(color: Colors.white),
                              labelText: "Email",
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor:Colors.white ,
                                labelStyle: TextStyle(color: Colors.white),
                                labelText: "Password"),
                          ),
                          Padding(padding: EdgeInsets.all(10.0)) ,
                          RaisedButton(
                              child: Text("Login"),
                              onPressed: () {
                                _signIn();
                              })
                        ],
                      ):
                      Center(
                        heightFactor: 7.5,
                        child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Already Logged In", style: TextStyle(color: Colors.white)),
                                Padding(padding: EdgeInsets.all(10.0)) ,
                                RaisedButton(
                                  onPressed: _logOut,
                                  child: Text("Logout"),
                                )
                              ],
                            )
                        )
                      )
          )
        ]
        )
      );
  }

  Future _getUser() async {

    FirebaseUser user = await _auth.currentUser();
    setState(() {
      currentUser = user;
    });
  }

  Future _signIn() async {
    FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text)
    .catchError((onError){
      print(onError);
    });
    if(user == null)
      {
        final snackBar = SnackBar(content: Text('Invalid Email or Password.'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      };
    _emailController.clear();
    _passwordController.clear();
    _getUser();
  }

  _logOut() {
    _auth.signOut();
    setState(() {
      currentUser = null;
    });
  }

}
