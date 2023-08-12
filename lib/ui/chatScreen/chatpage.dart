
import 'package:chatapp/ui/widget/chat_screen/body_msg.dart';
import 'package:chatapp/ui/widget/chat_screen/chat_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widget/chat_screen/icon.dart';

class Chat_screen extends StatefulWidget {
  String id;
  String currId;
  String name;
  Chat_screen({required this.id,required this.currId,required this.name,Key? key}) : super(key: key);

  @override
  State<Chat_screen> createState() => _Chat_screenState();
}

class _Chat_screenState extends State<Chat_screen> {

  late Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('chatroom').doc(widget.id).collection("masg").orderBy("currentdate",descending: true).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon_d(icon: Icons.arrow_back_rounded,),
        title: Text(widget.name),
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
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    return ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return ChatApp_bodyMsg(sender: data["currid"]==widget.currId?"sender":"",text: data["msg"],);
                      }).toList(),
                    );
                  },
                )
            ),
            Expanded(
                child: chat_input(id: widget.id,currId: widget.currId,))

          ],
        ),
      ),
    );
  }
}