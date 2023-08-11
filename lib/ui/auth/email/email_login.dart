import 'package:chatapp/ui/auth/email/email_signup.dart';
import 'package:chatapp/ui/auth/utility/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
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
                    child: Text("Sign your account using email and password"),
                  ),
                  Column(
                    children: [
                      Container(
                        color: Colors.white,
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: email,
                          validator: (value)=>value!.isEmpty?"Enter a Email":null,
                          decoration: InputDecoration(
                              hintText: "Email",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10)
                          ),

                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: password,
                          validator: (value)=>value!.isEmpty?"Input a password":null,
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 10)
                          ),

                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: ()=>Auth_utility().onEmailLogin(formkey: _formkey,email: email.text.toString(),password: password.text.toString(),context: context),
                          child: Text("Login")),
                      SizedBox(height: 50,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New here?"),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUP()));
                          },
                              child: Text("signup")
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