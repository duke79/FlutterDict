import 'package:flutter/material.dart';
import 'package:myapp/DatabaseServices.dart';

class SuggestionsViewState extends State<SuggestionsView> {

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new AnimatedList(
          key: _keyAnimatedList,
          itemBuilder: _buildItem,
        ));
  }

  /*Methods*/
  void _updateSuggestions() async{
    DatabaseServices.trie.then((trie){
      List<String> suggestions = trie.suggestions(prefix,length: 5);
      int i = 0;
      for(i=0;(i < suggestions.length) && (i<10);i++) {
        _suggestions.add(suggestions.elementAt(i));
        _keyAnimatedList.currentState.setState(() {//Todo: Does setState has any impact?
          _keyAnimatedList.currentState.insertItem(i);
        });
      }
    });
  }

  Widget _buildItem(BuildContext context, int index,
      Animation<double> animation) {
    if (index >= _suggestions.length)
      return null;
    return new Row(
      children: <Widget>[
        new Text(
          _suggestions.elementAt(index).toString().toLowerCase(),
          style: new TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }

  /*const fields*/
  static const String SELECT_100_WORDS = "select * from entries limit 0,100";
  static const String SELECT_ALL_TABLES = "SELECT name FROM sqlite_master WHERE type=\'table\'";
  static const String SELECT_WORDS_STARTING_WITH = "select * from entries where UPPER(word) like UPPER(\"INPUT_1%\") limit INPUT_2";

  /*Local fields*/
  Set<String> _suggestions = new Set<String>();
  String _prefix;
  static final GlobalKey<AnimatedListState> _keyAnimatedList = new GlobalKey<
      AnimatedListState>();

  String get _query {
    return SELECT_WORDS_STARTING_WITH.replaceAll(
        new RegExp(r"INPUT_1"), prefix).replaceAll(
        new RegExp(r"INPUT_2"), "30");
  }

  /*Public fields*/
  String get prefix => _prefix;

  set prefix(String value) {
    _prefix = value;
    if (null != _keyAnimatedList.currentState) {
      for(int i=_suggestions.length-1;i>=0;i--){
        _keyAnimatedList.currentState.removeItem(i,(BuildContext context, Animation<double> animation) {
          new Text("I am gone");
        });
      }
    }
    _suggestions.clear();
    if (_prefix.length < 1) return;

    //_updateSuggestions();
    _updateSuggestions();
  }
}

class SuggestionsView extends StatefulWidget {
  SuggestionsView({Key key}) :super(key: key);

  @override
  SuggestionsViewState createState() => new SuggestionsViewState();
}