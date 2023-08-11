import 'package:chatapp/ui/widget/chat_screen/Icon_widget.dart';
import 'package:flutter/material.dart';

File_dialog(context){
  showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context)=>Dialog(
        alignment: Alignment(0, 0.9),
        child: GridView(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 3
          ),
          children: [
            Icon_widget(icon: Icons.file_present, text: "Document",color: Colors.yellow,),
            Icon_widget(icon: Icons.camera_alt_rounded, text: "camera",color: Colors.green,),
            Icon_widget(icon: Icons.photo_size_select_actual_outlined, text: "gallery",color: Colors.indigo,),
            Icon_widget(icon: Icons.location_on, text: "location",color: Colors.orange,),
            Icon_widget(icon: Icons.headphones, text: "audio",color: Colors.green,),
            Icon_widget(icon: Icons.account_box, text: "contact",color: Colors.blue,),
          ],
        ),
      )
  );
}