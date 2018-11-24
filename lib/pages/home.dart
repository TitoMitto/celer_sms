import 'dart:convert';

import 'package:celer_sms/dialogs/common.dart';
import 'package:celer_sms/pages/message_thread.dart';
import 'package:celer_sms/pages/settings_page.dart';
import 'package:celer_sms/services/api.dart';
import 'package:celer_sms/tools/settings_manager.dart';
import 'package:celer_sms/utils/platform_utils.dart';
import 'package:celer_sms/utils/time_utils.dart';
import 'package:celer_sms/values/enums.dart';
import 'package:celer_sms/values/strings.dart';
import 'package:celer_sms/widgets/message_item.dart';
import 'package:celer_sms/widgets/search_bar.dart';
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
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _allInboxMessages = [];
  List<dynamic> _inboxMessages= [];
  ApiService api = ApiService();
  bool _isSearching = false;
  bool _hasText = false;

  SettingsManager settingsManager = SettingsManager();
  String cutText(String text, [length=40]){
    if(text.length > length) return text.substring(0, length)+ "...";
    else return text;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(_onSearch);
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
    _allInboxMessages = await getAllMessages();
    if(!_isSearching){
      _inboxMessages = _allInboxMessages;
    }
    print(_inboxMessages);
    setState((){});
  }
  void _testSend(){
    //_saveMessage(this.inboxMessages.first);
  }

  void _saveMessage(SmsMessage msg) async {
    var phoneNumber = await settingsManager.getPhoneNumber();
    Map data = {
      "from": msg.address.toString(),
      "message_body": msg.body.toString(),
      "date_sent": msg.dateSent.toString(),
      "date_received": msg.date.toString(),
      "message_id": msg.id?.toString() ?? 0.toString(),
      "uuid": msg.hashCode.toString(),
      "to": phoneNumber.toString()
    };
    print(data);
    api.saveMessage(data).then((response){
      print(response.body);
      bool successful;
      try {
        var responseBody = json.decode(response.body);
        successful = true;
      } catch(e){
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
      }else{
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

  void _onExitSearch(){
    setState(() {
      _isSearching = false;
      _inboxMessages = _allInboxMessages;
    });
  }
  void _onSearch(){
    setState(() {
      var _searchText = _searchController.text.toLowerCase();
      _inboxMessages = _allInboxMessages.where((item)=>
      item["address"].toString().toLowerCase().contains(_searchText) ||
          item["body"].toString().toLowerCase().contains(_searchText)
      ).toList();
    });
  }
  void _onClearSearch(){
    setState(() {
      _searchController.text = "";
      _inboxMessages = _allInboxMessages;
    });
  }

  void setOnMessageReceived(){
    receiver.onSmsReceived.listen((SmsMessage msg) async {
      showMessagesAfterMs(1);
      showMessagesAfterMs(10000);
      showMessagesAfterMs(30000);
    });
  }

  void showMessagesAfterMs(int time){
    setTimeout(() async {
      print("MSG_SHOW_TIMEOUT $time");
      _allInboxMessages = await getAllMessages();
      if(!_isSearching){
        _inboxMessages = _allInboxMessages;
      }


      setState(() {});
    }, time);
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
            appBar: (!_isSearching)? AppBar(
              actions: <Widget>[
                InkResponse(
                    radius: 5.0,
                    child: IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        tooltip: 'Refresh',
                        onPressed: (){
                          showMessagesAfterMs(1);
                        })
                ),
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
                            _isSearching  = true;
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
                          navigateToSettings();
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
            ): SearchBar(
              onClearSearch: _onClearSearch,
              onExitSearch: _onExitSearch,
              searchController: _searchController,
            ),
            body: (_allInboxMessages.length > 0)? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: _inboxMessages.length,
                  itemBuilder: (context, index){
                    return MessageItem(
                      id: 0,
                      synced: _inboxMessages[index]["synced"],
                      title: _inboxMessages[index]["address"],
                      date: _inboxMessages[index]["date_sent"],
                      body: _inboxMessages[index]["body"],
                      onTap: (){
                        openMessageThread(_inboxMessages[index]["thread_id"], _inboxMessages[index]["address"]);
                        print("Tapped Thread: ${_inboxMessages[index]["thread_id"]}");
                      },
                    );
                  }),
            ):Container(
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/images/smartphone.png", width: 80.0, height: 80.0,),
                  Text("No messages", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),),
                  Text("Received messages will be saved and displayed here. You can send a message to try it out.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ))
    );
  }
}
