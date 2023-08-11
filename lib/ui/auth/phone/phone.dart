
import 'package:chatapp/ui/auth/email/email_login.dart';
import 'package:chatapp/ui/auth/utility/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}


class _PhoneAuthState extends State<PhoneAuth> {

  var phoneController =TextEditingController();
  var otpController = TextEditingController();
  String Verificationid ="";
  CollectionReference users = FirebaseFirestore.instance.collection('user');




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.only(left: 20,right: 20,top: 40,bottom: 40),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("8658478536"),
                ),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 50,
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: phoneController,
                        decoration: InputDecoration(
                            hintText: "Input Mobile Number",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10)
                        ),

                      ),
                    ),
                    SizedBox(height: 100,),
                    ElevatedButton(onPressed: ()=>Auth_utility().onPhoneAuth(phone: phoneController.text.toString(), context: context),
                        child: Text("send Otp")),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                        },
                            child: Text("Login using Email and Password")
                        ),
                      ],
                    )

                  ],
                )

              ],
            ),
          ),
        )
    );
  }
}