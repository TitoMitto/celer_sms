import 'package:celer_sms/utils/date-utils.dart';
import 'package:flutter/material.dart';
import 'package:sms/contact.dart';
import 'package:sms/sms.dart';

class MessageItem extends StatelessWidget {
  int id;
  int threadId;
  String title;
  String body;
  String date;
  String photo;
  Function onTap;
  ContactQuery contacts = new ContactQuery();
  MessageItem({this.title, this.body, this.id, this.onTap, this.threadId, this.date});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70.0,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            new Container(
              width: 60.0,
              margin: EdgeInsets.only(left: 5.0),
              child: CircleAvatar(
                radius: 28.0,
                child: Icon(Icons.person, color: Colors.grey),
                backgroundColor: Color(0xFFefefef),
              ),
            ),
            new Expanded(child: new Container(
              padding: EdgeInsets.only(top: 15.0, left: 5.0),
              margin: EdgeInsets.only(right: 7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      Expanded(
                        flex:3,
                        child: new Container(
                          width: 162.0,
                          child: Text("$title", textAlign: TextAlign.start,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),),
                        ),
                      ),
                      new Container(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Text("${formatDate(date)}", textAlign: TextAlign.end,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.0, color: Color(0xFF474747)),),
                      )
                    ],
                  ),
                  Divider(height: 3.0, color: Colors.transparent),
                  new Container(
                    height: 20.0,
                    width: MediaQuery.of(context).size.width,
                    child: Text("$body",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),),
                  )

                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: Color(0xFFD3D3D3),
                          width: .5
                      )
                  )
              ),
            ))
          ],
        ),
      )
    );
  }
}
