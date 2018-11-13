import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({this.message, this.time, this.delivered, this.isMe});

  final String message, time;
  final delivered, isMe;

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Color(0xFFded4f4): Colors.white ;
    final align = isMe ?  CrossAxisAlignment.end: CrossAxisAlignment.start;
    final icon = delivered ? Icons.done_all : Icons.done;
    final iconColor = delivered ? Colors.lightBlueAccent : Colors.black38;
    final radius = isMe
        ? BorderRadius.only(
      topLeft: Radius.circular(5.0),
      bottomLeft: Radius.circular(5.0),
      bottomRight: Radius.circular(10.0),
    ): BorderRadius.only(
      topRight: Radius.circular(5.0),
      bottomLeft: Radius.circular(10.0),
      bottomRight: Radius.circular(5.0),
    );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: isMe? EdgeInsets.only(left: 50.0, right: 3.0, top: 3.0, bottom: 3.0): EdgeInsets.only(left: 3.0, right: 50.0, top: 3.0, bottom: 3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: Text(message,
                  style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.0,
                )),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    /*Text(time,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 12.0,
                        )),
                    SizedBox(width: 3.0),
                    Icon(
                      icon,
                      size: 14.0,
                      color: iconColor,
                    )*/
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}