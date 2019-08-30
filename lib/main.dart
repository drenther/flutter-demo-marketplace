import 'package:flutter/material.dart';

import './home.dart';
import './gateway.dart';
import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Demo Marketplace App'),
        GatewayScreen.routeName: (context) => GatewayScreen(),
        TransactionScreen.routeName: (context) => TransactionScreen()
      },
    );
  }
}
