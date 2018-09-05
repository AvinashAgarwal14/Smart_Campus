import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui' as ui;
import '../ui/home/home.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseReference = database.reference().child("Clubs_Admins");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //Image.network(widget.imageUrl, fit: BoxFit.cover),
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
            padding: const EdgeInsets.only(
                top: 16.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Create Account",
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password"
                  ),
                ),
                RaisedButton(
                  child: Text("Submit"),
                    onPressed: () {
                      _createAccount();
//                      HomePage();
                    })
              ],
            ),
          )
        ],
      ),
    );
  }

   Future _createAccount() async {
    FirebaseUser user  = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text);
    print("User created\n Email: ${user.email}");
    print(user.uid);
    _emailController.clear();
    _passwordController.clear();
    }

}
