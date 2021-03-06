import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/model/Screen.dart';
import 'package:myapp/data/Strings.dart';
import 'package:myapp/widgets/SearchBar.dart';
import 'package:myapp/widgets/Suggestions.dart';

class Search extends StatelessWidget {

  Search({Key key, this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*Initialization*/
    Screen.updateScreen(context);

    /*Hide StatusBar (top) & Android buttons (bottom)
  https://stackoverflow.com/a/43879271/9404410*/
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return new Scaffold(
      /*appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        */ /*title: new Text("Search"),*/ /*
      ),*/
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //SearchView
            new Builder(builder: _searchView,),
            //SuggestionsView
            new SuggestionsView(
              key: _keySuggestions,
              onSelected: (word) {
                Navigator.of(context).pushReplacementNamed(
                    Strings.route_result + "/" + word);
              },
            ),
          ],
        ),
      ),
    );
  }

  /*Methods*/
  Widget _searchView(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: Screen.width / 20,),
      width: Screen.width / Screen.GOLDEN_RATIO,
      child: new Hero(
        tag: Strings.widgetTag_prefix,
        child: new SearchBar(
          new SearchViewParams(
            _controller,
            onChangedCB: (value) {
              _keySuggestions.currentState.prefix = value;
            },
            onSubmittedCB: (value) {
              Navigator.of(context).pushReplacementNamed(
                  Strings.route_result + "/" + value);
            },
            focusNode: focusNode,
            decoration: new InputDecoration(
              labelStyle: Theme
                  .of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Theme
                  .of(context)
                  .primaryColor),
            ),
          ),
        ),
      ),
    );
  }

  /*Local fields*/
  final TextEditingController _controller = new TextEditingController();
  static final GlobalKey<Suggestions> _keySuggestions = new GlobalKey<
      Suggestions>();

  /*Public fields*/
  FocusNode focusNode;
}