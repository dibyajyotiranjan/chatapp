

import 'package:chatapp/ui/chatScreen/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllUser extends StatefulWidget {
  String Uid;
  AllUser({required this.Uid,super.key});

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('user').snapshots();
  chatroom(String id,String name)async{
   QuerySnapshot chatroom = await FirebaseFirestore.instance.collection('chatroom').where("participents.${widget.Uid}",isEqualTo:true).where("participents.${id}",isEqualTo:true).get();
   var msg;
   if(chatroom.docs.length>0){
    var docid = chatroom.docs[0]["id"];
    msg = docid;
   }else{
     await FirebaseFirestore.instance.collection('chatroom').add({
       "participents":{
         widget.Uid:true,
         id:true
       }
     }).then((value) {
       var participent ={
         "currentuser":id,
         "targetuser":widget.Uid
       };
       FirebaseFirestore.instance.collection('chatroom').doc(value.id).set({
       "id":value.id,
       "participents":{
         widget.Uid:true,
         id:true
       }
     });
       msg =value.id;
     });
   }
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Chat_screen(id: msg,currId: widget.Uid,name: name,)));


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
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
              return InkWell(
                onTap: ()=>chatroom(data["Uid"],data["name"]),
                child: ListTile(
                  leading: Icon(Icons.supervised_user_circle),
                  title: Text(data['name']),
                  //subtitle: Text(data['email']),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
