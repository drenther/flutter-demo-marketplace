import 'package:flutter/material.dart';

class CompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Transaction Completed')),
        body: Center(
            child: Column(children: <Widget>[
          RaisedButton(
              child: Text('Go back to home'),
              onPressed: () {
                Navigator.pop(context);
              })
        ])));
  }
}
