import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/RandomWords.dart';

class SecondRoute extends StatelessWidget {
  final String data;

  SecondRoute({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RandomWords(true)
    );
      Scaffold(
      appBar: AppBar(
          title: Text(data),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('$data Go back!'),
        ),
      ),
    );
  }
}
