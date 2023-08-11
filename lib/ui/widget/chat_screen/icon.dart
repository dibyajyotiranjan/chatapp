
import 'package:flutter/material.dart';

class Icon_d extends StatefulWidget {
  IconData icon;
  Icon_d({required this.icon,Key? key}) : super(key: key);

  @override
  State<Icon_d> createState() => _Icon_dState();
}

class _Icon_dState extends State<Icon_d> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      child: Icon(widget.icon),
    );
  }
}
