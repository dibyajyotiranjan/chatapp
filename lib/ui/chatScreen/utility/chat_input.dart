import 'package:cloud_firestore/cloud_firestore.dart';

class MsgInput{
  UserChat(String id,text,currentUserdId) async{

    var msgbox = await FirebaseFirestore.instance.collection('chatroom').doc(id).collection("masg");
        msgbox.add({
       "msg":text
      }).then((value) => msgbox.doc(value.id).set(
          {
            "id":value.id,
            "msg":text,
            "currentdate": DateTime.now(),
            "currid":currentUserdId
          }
        ));
  }
}