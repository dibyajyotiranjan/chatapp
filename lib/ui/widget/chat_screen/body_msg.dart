import 'package:flutter/material.dart';

class ChatApp_bodyMsg extends StatefulWidget {
  String sender;
  String? text;
  String? image;
  String? audio;

  ChatApp_bodyMsg({required this.sender, this.text, this.image, this.audio});

  @override
  State<ChatApp_bodyMsg> createState() => _ChatApp_bodyMsgState();
}

class _ChatApp_bodyMsgState extends State<ChatApp_bodyMsg> {
  late OverlayState _overlayState;
  late OverlayEntry _overlayEntry;
  void _insertOverlay(BuildContext context) {
    //_overlayEntry?.remove();
    _overlayState = Overlay.of(context);
    _overlayEntry =OverlayEntry(
          maintainState: true,
            builder: (context) {
          final size = MediaQuery
              .of(context)
              .size;
          return Positioned(
            width: size.width*1,
            height: 50,
            top: 50,
            //left: size.width - 72,
            child: Material(
              color: Colors.transparent,
              child: Container(
                //height: 100,
                //width: 500,
                decoration: BoxDecoration(
                    color: Colors.blue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: ()=>_overlayEntry?.remove(),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.reply),
                          Icon(Icons.star),
                          Icon(Icons.file_copy_outlined),
                          InkWell(
                            onTap: ()async{
                            },
                              child: Icon(Icons.delete)),
                          Icon(Icons.share),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    _overlayState.insert(_overlayEntry);
  }


  @override
  Widget build(BuildContext context) {
    if (widget.text != "") {
      return InkWell(
        onLongPress: ()=>_insertOverlay(context),
        onTap: (){_overlayEntry?.remove();},
        child: Container(

          //alignment: Alignment.topLeft,
          margin: widget.sender=="sender"
              ? EdgeInsets.only(top: 10, left: 100)
              : EdgeInsets.only(top: 10, right: 100),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: Text(widget.text!, style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    backgroundColor: Colors.blue
                ),),
              ),
              Expanded(
                child:
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.done_all),
                    )
              )
            ],
          ),
        ),
      );
    } else if (widget.image != "") {
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // mainAxisSpacing: 2,
            // crossAxisSpacing: 2
          ),
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container(height: 100,
              margin: widget.sender=="sender"
                  ? EdgeInsets.only(top: 10, left: 100)
                  : EdgeInsets.only(top: 10, right: 100),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black54),
                image: DecorationImage(
                    image: AssetImage("asset/image/nda.jpg"),
                    fit: BoxFit.cover
                ),

              ),
            );
          });
    } else if (widget.audio != null) {
      return SizedBox();
    } else {
      return SizedBox();
    }
  }
}

