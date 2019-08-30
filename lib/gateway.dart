import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import './transaction.dart';
import './utils.dart';

class GatewayScreenArguments {
  final String redirectUrl;

  GatewayScreenArguments(this.redirectUrl);
}

class GatewayScreen extends StatefulWidget {
  static const routeName = '/gateway';

  @override
  _GatewayScreenState createState() => new _GatewayScreenState();
}

class _GatewayScreenState extends State<GatewayScreen> {
  final webviewPlugin = new FlutterWebviewPlugin();

  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  @override
  void dispose() {
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    webviewPlugin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    webviewPlugin.close();

    _onDestroy = webviewPlugin.onDestroy.listen((_) {
      print('destroy');
    });

    _onStateChanged =
        webviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print('state changed - ${state.type} ${state.url}');
    });

    _onUrlChanged = webviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        print('URL changed: $url');

        if (url.startsWith(REDIRECT_URL)) {
          String transactionRef = url.split('&')[1].split('=')[1];
          String status = url.split('&')[2].split('=')[1];

          Navigator.pushNamed(context, TransactionScreen.routeName,
              arguments: TransactionScreenArguments(transactionRef, status));

          webviewPlugin.close();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final GatewayScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    return WebviewScaffold(
      url: args.redirectUrl,
      appBar: AppBar(title: Text('Secure Gateway')),
    );
  }
}
