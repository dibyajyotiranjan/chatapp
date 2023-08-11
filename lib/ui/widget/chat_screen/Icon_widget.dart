
import 'package:flutter/material.dart';

class Icon_widget extends StatefulWidget {
  IconData icon;
  String text;
  Color color;
  Icon_widget({required this.icon,required this.text,required this.color, Key? key}) : super(key: key);

  @override
  State<Icon_widget> createState() => _Icon_widgetState();
}

class _Icon_widgetState extends State<Icon_widget> {

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle
            ),
            child: Icon(widget.icon,)),
        Text(widget.text,style: TextStyle(fontSize: 15),)
      ],
    );
  }
}
