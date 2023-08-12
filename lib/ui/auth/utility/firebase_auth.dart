import 'package:chatapp/ui/auth/email/email_login.dart';
import 'package:chatapp/ui/chatScreen/chatpage.dart';
import 'package:chatapp/ui/home.dart';
import 'package:chatapp/ui/user/all_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth_utility {

  onEmail_signup({required formkey,required email,required password,required name,required context})async{
    if (formkey.currentState!.validate()) {
      try {
        var userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        ).then((value){
          FirebaseFirestore.instance.collection("user").doc(value.user!.uid).set({
            "Uid":value.user!.uid,
            "name":name,
            "email":email,
            "password":password
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SignUP sucessfully")));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }else{
      print("Error");
    }

  }
  onEmailLogin({required formkey,required email,required password,required context})async{
    if(formkey.currentState!.validate()){
      try {
        var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password
        ).then((value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AllUser(Uid: value.user!.uid)));});
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please input a valid Email")));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your password is wrong")));
        }
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You Input a wrong formate")));
    }

  }
  onPhoneAuth({required phone,required context}) async{
    TextEditingController otp =TextEditingController();
    FirebaseAuth auth =FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: "+91" + phone.trim(),
      verificationCompleted: (PhoneAuthCredential credential) async{

        await FirebaseAuth.instance.signInWithCredential(credential).then((value){

            Navigator.push(context, MaterialPageRoute(builder: (context)=>AllUser(Uid: value.user!.uid)));});
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async{
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                title: Text("Give the code?"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller:otp,
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("Confirm"),
                    // textColor: Colors.white,
                    // color: Colors.blue,
                    onPressed: () async{
                      final code = otp.text.trim();
                      AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);

                      UserCredential result = await auth.signInWithCredential(credential);

                      User? user = result.user;

                      if(user != null){
                        FirebaseFirestore.instance.collection("user").doc(user.uid).set({
                          "Uid":user.uid,
                          "name":"+91" + phone.trim(),
                          // "email":email,
                          // "password":password
                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => AllUser(Uid: user.uid)
                        ));
                      }else{
                        print("Error");
                      }
                    },
                  )
                ],
              );
            }
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
  Future<Widget?> signInWithGoogle({required context}) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    if(userCredential.user !=null){
      await FirebaseFirestore.instance.collection("user").doc(userCredential.user!.uid).set({
        "Uid":userCredential.user!.uid,
        "name":userCredential.user!.displayName,
        "email":userCredential.user!.email,
        "password":userCredential.user!.phoneNumber
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AllUser(Uid: userCredential.user!.uid)));
    }
  }

  LogOut(context)async{
    await FirebaseAuth.instance.signOut().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyHomePage()), (route) => false));
  }
}