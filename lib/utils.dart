import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const API_URL = 'https://cp-gateway-dev.herokuapp.com';
const CLIENT_ID = '5aXqYKfyhppH9iamUFcQLzQ36xQm7mqz';
const CLIENT_SECRET =
    'GV3TWAUMWJEAIskm4SEN4IQLTYTvHZI8QUsop3w88_wLBS8PHk8tKGSK3k3acUXX';

const REDIRECT_URL = 'https://cp-b2bshop-dev.herokuapp.com/transaction';
const REF = '5d36e27da8cd80438500966e';

String _getValueFromJSON(Map<String, dynamic> json, key) {
  return json[key];
}

Future<String> fetchAccessToken() async {
  final response = await http.post('$API_URL/thirdparty/merchants/accessToken',
      body: {'clientId': CLIENT_ID, 'clientSecret': CLIENT_SECRET});

  final jsonResponse = json.decode(response.body);

  return _getValueFromJSON(jsonResponse, 'accessToken');
}

Future<String> fetchRedirectURL(String orderRef, int amount) async {
  final accessToken = await fetchAccessToken();

  final response =
      await http.post('$API_URL/thirdparty/merchants/credit/initiate', body: {
    'orderRef': orderRef,
    'amount': amount.toString(),
    'buyerRef': REF,
    'userRef': REF,
    'redirectSuccessUrl': REDIRECT_URL,
    'redirectFailureUrl': REDIRECT_URL
  }, headers: {
    HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    HttpHeaders.contentTypeHeader: 'application/json'
  });

  final jsonResponse = json.decode(response.body);

  return _getValueFromJSON(jsonResponse, 'redirectUrl');
}

Future<void> acknowledgeTransaction(String transactionRef) async {
  await http
      .put('$API_URL/thirdparty/merchants/credit/$transactionRef/acknowledge');
}
