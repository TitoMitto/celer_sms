import 'package:celer_sms/widgets/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:sms/sms.dart';

class MessageThreadPage extends StatefulWidget {
  int threadId;
  String address;
  MessageThreadPage({@required this.threadId, @required this.address});
  @override
  _MessageThreadPageState createState() => _MessageThreadPageState();
}

class _MessageThreadPageState extends State<MessageThreadPage> {
  SmsQuery query = new SmsQuery();
  List<SmsThread> threads = [];
  List<SmsMessage> threadMessages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getThreadMessages();
  }
  void getThreadMessages() async {
    threads = await query.queryThreads([this.widget.threadId], kinds: [SmsQueryKind.Inbox, SmsQueryKind.Sent]);
    threadMessages = threads.first.messages.reversed.toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        elevation: .9,
        title: Text(
          "${widget.address}",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.call,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 2.0, left: 10.0, right: 10.0, bottom: 5.0),
                child: ListView.builder(
                    itemCount: threadMessages.length,
                    itemBuilder: (context, index){
                      return MessageBubble(
                        message: '${threadMessages[index].body}',
                        time: '12:00',
                        delivered: threadMessages[index].state == SmsMessageState.Delivered? true: false,
                        isMe: (threadMessages[index].kind == SmsMessageKind.Received)? false: true,
                      );
                    }),
              ),
            ),
            Container(
              height: 50.0,
              margin: EdgeInsets.only(right: 5.0, bottom: 5.0, left: 5.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 5.0),
                     decoration: BoxDecoration(
                         color: Colors.white,
                       borderRadius: BorderRadius.all(Radius.circular(100.0)),
                       boxShadow: [BoxShadow(color: Colors.grey[400], blurRadius: 4.0, offset: Offset(1.0, 4.0))]
                     ), 
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: 50.0,
                    child: Icon(Icons.send, color: Colors.white),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.0, offset: Offset(2.0, 3.0))]
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

