
import 'package:chatapp/ui/widget/chat_screen/body_msg.dart';
import 'package:chatapp/ui/widget/chat_screen/chat_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widget/chat_screen/icon.dart';

class Chat_screen extends StatefulWidget {
  const Chat_screen({Key? key}) : super(key: key);

  @override
  State<Chat_screen> createState() => _Chat_screenState();
}

class _Chat_screenState extends State<Chat_screen> {
  List mssr = ["sender","recever dibya jyoti ranjan and thsis is a good handrawterrecever dibya jyoti ranjan and thsis is a good handrawter","","sender","recever","sender","recever","recever","recever","sender","sender","recever","sender","sender","recever","sender","recever","recever","recever","sender","sender","recever","sender","sender","recever","sender","recever","recever","recever","sender","sender","recever","sender","sender","recever","sender","recever","recever","recever","sender","sender","recever","sender","sender","recever","sender","recever","recever","recever","sender","sender","recever","sender","sender","recever","sender","recever","recever","recever","sender","sender","recever","sender","sender","recever","sender","recever","recever","recever","sender","sender","recever","sender","sender","recever","sender","recever","recever","recever","sender","sender","recever","sender","sender","recever","sender","recever","recever","recever","sender","sender","recever","sender","sender","recever","sender","recever","recever","recever","sender"];
  List imm =["","","dibya","","","",""];

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('message').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon_d(icon: Icons.arrow_back_rounded,),
        title: Text("Jonny Wilson"),
        actionsIconTheme: IconThemeData(
            opticalSize: 10
        ),
        actions: [
          Icon_d(icon: Icons.call),
          Icon_d(icon: Icons.video_call),
          Icon_d(icon: Icons.more_horiz),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            Expanded(
                flex: 9,
                child: ListView.builder(
                    itemCount: mssr.length,
                    itemBuilder: (context,index){
                      return ChatApp_bodyMsg(sender: mssr[index],text: mssr[index],);
                    })
            ),
            Expanded(
                child: chat_input())

          ],
        ),
      ),
    );
  }
}