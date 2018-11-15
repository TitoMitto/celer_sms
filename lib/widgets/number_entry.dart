import 'package:flutter/material.dart';

class NumberEntry extends StatelessWidget {
  TextEditingController phoneNumber;
  Function onFinish;
  NumberEntry({this.onFinish, this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(28.0),
            child: Text(
              //"Celer SMS will send an SMS message (carrier charges may apply) to verify your phone number. Enter your country code and phone number.",
              "Celer SMS will use the phone number you enter to send and receive messages from your phone.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, color:Color(0xFF747678), fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(6.0).copyWith(left: 20.0),
            margin: EdgeInsets.only(left:30.0, right: 30.0),
            child: TextFormField(
              controller: phoneNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Phone number",
                  //labelText: "Sent time key",
                  border: InputBorder.none
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              margin: EdgeInsets.only(right: 30.0, top: 10.0),
              child: MaterialButton(
                onPressed: onFinish,
                child: Text("FINISH", style: TextStyle(fontSize: 16.0, color: Colors.white),),
                color: Theme.of(context).primaryColor,
                height: 45.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
