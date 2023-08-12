import 'package:chatapp/ui/auth/email/email_login.dart';
import 'package:chatapp/ui/auth/phone/phone.dart';
import 'package:chatapp/ui/auth/utility/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
              child: Image.asset("assets/image/login.jpg",fit: BoxFit.cover,)),
          Expanded(
            flex: 1,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                        },
                        child: Text("Sign in With Email")),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneAuth()));
                        },
                        child: Text("Sign in With Mobile No")),
                    ElevatedButton(
                        onPressed: ()=>Auth_utility().signInWithGoogle(context: context),
                        child: Text("Sign in With Google")),
                  ],
                ),
              ))
        ],
      )
    );
  }
}