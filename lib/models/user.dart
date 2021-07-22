import 'package:flutter/material.dart';

class AjaxUser {
  //send auth info with all requests
  String uid = "";
  String username = "";
  String emailAddress = "";
  num balance = 0;
  String pfpUrl = "";

  AjaxUser(
      this.uid, this.username, this.emailAddress, this.balance, this.pfpUrl){

  }

  static getDummyAccount() {
    return AjaxUser("123456", "anair123", "arjun@nairsnet.com", 21.87,
        "https://dw3jhbqsbya58.cloudfront.net/rosters/a9cbf684-16ef-4997-9539-15fefe9df410/e/5/5/e55dc629-91aa-ea11-80ce-a444a33a3a97/thumbnail.jpg?version=637389721377004039");
  }
}
