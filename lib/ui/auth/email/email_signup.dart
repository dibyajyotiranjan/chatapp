
import 'package:chatapp/ui/auth/email/email_login.dart';
import 'package:chatapp/ui/auth/utility/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUP extends StatefulWidget {
  const SignUP({super.key});

  @override
  State<SignUP> createState() => _SignUPState();
}


class _SignUPState extends State<SignUP> {
  final _formkey = GlobalKey<FormState>();
  var nameController =TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('user');

var auth =Auth_utility();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.only(left: 20,right: 20,top: 40,bottom: 40),
          child: SafeArea(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Signup your account and chat with friend"),
                  ),
                  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 50,
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: nameController,
                          validator: (value) {
                            return value!.isEmpty ? "Enter name it is required" : null;
                          },
                          decoration: InputDecoration(
                              hintText: "Name",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10)
                          ),

                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 50,
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10)
                          ),
                          validator: (value) {
                            return value!.isEmpty ? "Enter name" : null;
                          },

                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 50,
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: passwordController,
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10)
                          ),
                          validator: (value) {
                            return value!.isEmpty ? "Enter name" : null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(onPressed: ()=>auth.onEmail_signup(formkey: _formkey,email: emailController.text.toString(),password: passwordController.text.toString(),name: nameController.text.toString(),context: context),
                          child: Text("signup")),
                      SizedBox(height: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                          },
                              child: Text("Login")
                          ),
                        ],
                      )

                    ],
                  )

                ],
              ),
            ),
          ),
        )
    );
  }
}