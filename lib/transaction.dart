import 'package:flutter/material.dart';

import './utils.dart';

class TransactionScreenArguments {
  final String transactionRef;
  final String status;

  TransactionScreenArguments(this.transactionRef, this.status);
}

class TransactionScreen extends StatelessWidget {
  static const routeName = '/transaction';

  @override
  Widget build(BuildContext context) {
    final TransactionScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(title: Text('Transaction Completed')),
        body: Center(
            child: Column(children: <Widget>[
          Text('Transaction Ref: ${args.transactionRef}'),
          Text('Status: ${args.status}'),
          RaisedButton(
            child: Text('Acknowledge Transaction Completion'),
            onPressed: () async {
              await acknowledgeTransaction(args.transactionRef);

              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
          RaisedButton(
              child: Text('Go back to home'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              })
        ])));
  }
}
