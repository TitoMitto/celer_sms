import 'dart:convert';

import 'package:celer_sms/dialogs/common.dart';
import 'package:celer_sms/pages/message_thread.dart';
import 'package:celer_sms/pages/settings.dart';
import 'package:celer_sms/services/api.dart';
import 'package:celer_sms/values/enums.dart';
import 'package:celer_sms/values/strings.dart';
import 'package:celer_sms/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import 'package:flushbar/flushbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SmsQuery query = new SmsQuery();
  SmsReceiver receiver = new SmsReceiver();
  List<SmsMessage> inboxMessages= [];
  ApiService api = ApiService();
  bool _isSearch = false;
  bool _hasText = false;
  String cutText(String text, [length=40]){
    if(text.length > length) return text.substring(0, length)+ "...";
    else return text;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setMessages();
    setOnMessageReceived();
  }

  void navigateToSettings(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return SettingsPage();
    }));
  }

  void openMessageThread(threadId, address){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return MessageThreadPage(threadId: threadId, address: address,);
    }));
  }
  void setMessages() async {
    this.inboxMessages = await query.querySms(
      kinds: [SmsQueryKind.Inbox]
    );
    print(inboxMessages);
    setState((){});
  }

  void _saveMessage(SmsMessage msg){
    api.saveMessage({
      "address":msg.address.toString(),
      "dateSent":msg.dateSent.toString(),
      "date":msg.date.toString(),
      "thread_id":msg.threadId.toString(),
      "body": msg.body.toString(),
    }).then((response){
      print(response.body);
      bool successful;
      try {
        var responseBody = json.decode(response.body);
        successful = true;
      }catch(e){
        successful = false;
      }

      if(successful){
        successful = true;
        Flushbar()
          ..title = "Successful"
          ..message = "Message synced successfuly"
          ..backgroundColor = Colors.green
          ..shadowColor = Colors.green[800]
          ..duration = Duration(seconds: 3)
          ..show(context);
      } else {
        Flushbar()
          ..title = "An error occured"
          ..message = "Could not parse response"
          ..backgroundColor = Colors.red
          ..shadowColor = Colors.red[800]
          ..duration = Duration(seconds: 3)
          ..show(context);
      }
    });


  }

  void setOnMessageReceived(){
    receiver.onSmsReceived.listen((SmsMessage msg) {
      _saveMessage(msg);
      setMessages();
      print("Received new message from ${msg.address}  AND its state is ${msg.state}");
    });
  }

  void openSettings(){

  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFF7D4EEC), //Changing this will change the color of the TabBar
          accentColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: (!_isSearch)? AppBar(
              actions: <Widget>[
                InkResponse(
                    radius: 5.0,
                    child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        tooltip: 'Search',
                        onPressed: (){
                          setState(() {
                            _isSearch  = true;
                          });
                        })
                ),
                PopupMenuButton<HomeMenuOptions>(
                    onSelected: (HomeMenuOptions result) {
                      switch(result){
                        case HomeMenuOptions.about: {
                          alert(context, "$appName ", "v$appVersion \nDate: $updateDate");
                          break;
                        }
                        case HomeMenuOptions.settings: {
                          //openSettings();
                          break;
                        }
                      }
                    },
                    tooltip: "Home Menu",
                    itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<HomeMenuOptions>>[
                      PopupMenuItem<HomeMenuOptions>(
                        value: HomeMenuOptions.about,
                        child: const Text('About'),
                      ),
                      PopupMenuItem<HomeMenuOptions>(
                        value: HomeMenuOptions.settings,
                        child: const Text('Settings'),
                      )
                    ]
                )
              ],
              title: Text("Celer SMS"),
              bottom: TabBar(tabs: [
                Tab(text: "INBOX"),
                Tab(text: "OUTBOX"),
                Tab(text: "PREFERENCE")
              ]),
            ): AppBar(
              backgroundColor: Colors.white,
              title: TextFormField(
                autofocus: true,
                onSaved: (String my){
                  showToast("Saving $my");
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search...",
                    hintStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500 )
                ),
              ),
              leading: InkResponse(
                onTap: (){
                  setState(() {
                    _isSearch = false;
                  });
                },
                child: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor,),
              ),
            ),
            body: TabBarView(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    itemCount: inboxMessages.length,
                    itemBuilder: (context, index){
                  return MessageItem(
                    id: inboxMessages[index].id,
                    title: inboxMessages[index].address,
                    date: inboxMessages[index].dateSent.toString(),
                    body: inboxMessages[index].body,
                    onTap: (){
                      openMessageThread(inboxMessages[index].threadId, inboxMessages[index].address);
                      print("Tapped Thread: ${inboxMessages[index].threadId}");
                    },
                  );
                }),
              ),
              Text("Outbox"),
              Text("Preferences")
            ]),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.orangeAccent,
                child: Icon(Icons.message, color: Colors.white,),
                onPressed: (){

                }),
          ))
    );
  }
}
