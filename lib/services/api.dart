import 'dart:convert';

import 'package:ajax/models/payment.dart';
import 'package:ajax/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future<AjaxUser> getAjaxUser() async {
  return callApi("getUser", "get").then((user) => AjaxUser.fromJson(user));
}

Future<String> getPlaidLinkToken() async {
  return callApi("getPlaidLinkToken", "get").then((response) => response["link_token"]);
}

Future<String> makePayment(
    String recipientEmail, num amount, String message) async {
  String senderId = FirebaseAuth.instance.currentUser!.uid;
  return callApi("makePayment", "post", params: {
    "senderId": senderId,
    "recipientEmail": recipientEmail,
    "amount": amount.toString(),
    "message": message,
  }).then((response) {
    print(response);
    return response["message"];
  });
}

Future<List<Payment>> getPayments() async {
  return callApi("getPayments", "get").then((response) {
    var payments = response["payments"];
    List<Payment> paymentsList =
        payments.map<Payment>((payment) => Payment.fromJson(payment)).toList();
    return paymentsList;
  });
}

Future<Map<String, dynamic>> callApi(String url, String method,
    {Map<String, dynamic> params = const {}}) {
  method = method.toLowerCase();
  User? currentUser = FirebaseAuth.instance.currentUser;
  return currentUser!.getIdToken().then((token) async {
    var uri = Uri.parse(
        "https://us-central1-ajax-b5934.cloudfunctions.net/api/" + url);
    http.Response response;
    if (method == "get") {
      response =
          await http.get(uri, headers: {"Authorization": "Bearer " + token});
    }
    // (method == "post")
    else {
      response = await http.post(uri,
          headers: {"Authorization": "Bearer " + token}, body: params);
    }

    // print(response.statusCode);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("API responded with status code: " +
          response.statusCode.toString() +
          " and message " +
          response.body);
    }
  });
}
