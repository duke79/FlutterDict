import 'package:flutter/material.dart';
import 'package:myapp/DatabaseServices.dart';
import 'package:sqflite/sqflite.dart';

class SuggestionsView extends StatefulWidget {

  @override
  SuggestionsViewState createState() => new SuggestionsViewState();
}

class SuggestionsViewState extends State<SuggestionsView> {
  String selectWords = "select * from entries limit 0,100";
  String selectTables = "SELECT name FROM sqlite_master WHERE type=\'table\'";

  addSuggestions(Database db) async{
    debugPrint("Stuggestions: ");
    List<Map> list = await db.rawQuery(selectWords);
    debugPrint(list.length.toString());
    debugPrint(" : ");
    debugPrint(list.toString());
  }
  
  @override
  Widget build(BuildContext context) {
    debugPrint("Loading DB for Stuggestions: ");
    DatabaseServices.loadDictionaryDB().then(
      (Database db){
        debugPrint("DB loaded, adding suggestions: ");
        addSuggestions(db);
      }
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        new Container(
          margin: new EdgeInsets.only(bottom: 10.0,),
          child: new Row(
            children: <Widget>[
              new Text("Fellow",
                style: new TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
        new Container(
          margin: new EdgeInsets.only(bottom: 10.0,),
          child: new Row(
            children: <Widget>[
              new Text("Felix",
                style: new TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}