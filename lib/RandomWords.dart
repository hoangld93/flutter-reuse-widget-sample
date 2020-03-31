import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SecondRoute.dart';

class RandomWords extends StatefulWidget {
  final bool isShowBtnBack;

  RandomWords(this.isShowBtnBack);

  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState(isShowBtnBack);
  }
}

class RandomWordsState extends State<RandomWords> {
  RandomWordsState(this.isShowBtnBack);

  int idSelected = -1;
  List<WordPair> _suggestions = <WordPair>[];
  final bool isShowBtnBack;
  final _biggerFont = const TextStyle(
      fontSize: 18.0, backgroundColor: Colors.amberAccent, color: Colors.red);

  Widget getBtnBack() {
    if (isShowBtnBack)
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, false),
      );
    return Scaffold();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _suggestions.addAll(generateWordPairs().take(10));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isShowBtnBack)
      return Scaffold(
        appBar: AppBar(
            title: Text('Startup Name Generator'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: getBody(),
      );
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Startup Name Generator'),
//      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
            child: _buildSuggestions(),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                child: Text("Add List More 10"),
                onPressed: () {
                  setState(() {
                    _suggestions.addAll(generateWordPairs().take(10));
                  });
                },
              )),
        ],
      ),
    );
  }

// user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Color getColor(int pos) {
    if (pos == idSelected) return Colors.lightGreen;
    return Colors.white;
  }

  Widget _buildRow(WordPair pair, int pos) {
    return new ListBody(
      children: <Widget>[
        new GestureDetector(
          onTap: () {
//            _showDialog();
            setState(() {
              idSelected = pos;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SecondRoute(data: pair.asPascalCase)),
            );
          },
          child: new Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                color: getColor(pos),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new CircleAvatar(backgroundColor: Colors.red),
                    new Padding(padding: EdgeInsets.all(4)),
                    new Column(
                      children: <Widget>[
                        new Text(pair.asPascalCase, style: _biggerFont),
                        new Text(pair.asPascalCase, style: _biggerFont),
                      ],
                    )
                  ],
                ),
              ),
              new Divider()
            ],
          ),
        )
      ],
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: _suggestions.length,
      itemBuilder: (context, pos) {
//        if (pos.isOdd) return Divider();
//        final index = pos ~/ 2;
        // If you've reached at the end of the available word pairs...
//        if (pos >= _suggestions.length) {
////         ...then generate 10 more and add them to the suggestions list.
//          return Scaffold();
//        }
        return _buildRow(_suggestions[pos], pos);
      },
    );
  }
}