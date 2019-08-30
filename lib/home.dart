import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import './utils.dart';
import './gateway.dart';

final _currencyFormatter = new NumberFormat('#,##0.00', 'en_IN');

final _uuid = new Uuid();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _orderRef = _uuid.v4();
  int _amount = 0;

  void _amountUpdate(_a) {
    setState(() {
      _amount = int.parse(_a);
    });
  }

  void _generateNewOrderRef() {
    setState(() {
      _orderRef = _uuid.v4();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Order Ref: $_orderRef'),
            RaisedButton(
              child: Text('Generate New Order Ref'),
              onPressed: _generateNewOrderRef,
            ),
            Text(
              'Amount: ₹ ${_currencyFormatter.format(_amount)}',
            ),
            TextField(
              onChanged: _amountUpdate,
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(hintText: 'Please enter an amount value'),
            ),
            RaisedButton(
              child: Text('Initiate Order'),
              onPressed: () async {
                final redirectUrl = await fetchRedirectURL(_orderRef, _amount);

                print(redirectUrl);

                Navigator.pushNamed(context, GatewayScreen.routeName,
                    arguments: GatewayScreenArguments(redirectUrl));
              },
            )
          ],
        ),
      ),
    );
  }
}
