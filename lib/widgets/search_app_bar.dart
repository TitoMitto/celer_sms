import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget{
  var searchController;
  double width = double.infinity;
  final Function onExitSearch;
  final Function onClearSearch;
  //String
  SearchAppBar({this.searchController, this.onExitSearch, this.onClearSearch});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        autofocus: true,
        controller: searchController,
        onSaved: (String my){
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search...",
            hintStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500 )
        ),
      ),
      leading: InkResponse(
        onTap: onExitSearch,
        child: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor,),
      ),
      actions: <Widget>[
        (searchController.text != "")? GestureDetector(
          onTap: onClearSearch,
          child: Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Icon(Icons.close, color: Theme.of(context).primaryColor,),
          ),
        ): new Container()
      ],
    );
  }

  // TODO: implement preferredSize
  @override
  Size get preferredSize => Size(width, kToolbarHeight);

}
