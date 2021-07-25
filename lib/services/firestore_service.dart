import 'package:ajax/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //following three lines of code make this a singleton i believe
  FirestoreService._privateConstructor();

  static final FirestoreService _instance =
      FirestoreService._privateConstructor();

  static FirestoreService get instance => _instance;

  Future<AjaxUser> getUserByUid(uid) {
    print("getting user by uid");
    CollectionReference users = firestore.collection("User");
    return users.doc(uid).get().then((data) {
      print("got document");
      dynamic userData = data.data();
      print(userData);
      AjaxUser user = AjaxUser(uid, userData["displayName"], userData["email"],
          userData["balance"], userData["photoURL"]);
      return user;
    });
  }

  Future<void> makePayment(
      String senderUid, String recipientUid, num amount) async {
    // Future<void> getFruit() async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('makePayment');
    callable({
      "senderUid": senderUid,
      "recipientUid": recipientUid,
      "amount": amount
    }).then((response){
      print(response.data);
    });
    // List fruit =
    //     results.data; // ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"]
    // }
  }

// Future<void> makePayment(String senderUid, String recipientUid, num amount){
//   if(amount <= 0){
//     print(amount);
//     throw new Exception("Amount must be greater than 0");
//   }
//   WriteBatch batch = firestore.batch();
//   DocumentReference senderDoc = firestore.collection("User").doc(senderUid);
//   batch.update(senderDoc, {
//     "balance": FieldValue.increment(-amount),
//   });
//   DocumentReference recipientDoc = firestore.collection("User").doc(senderUid);
//
//   // batch.update(recipientDoc, {
//   //   "balance": FieldValue.increment(balance)
//   // });
//
//   return batch.commit();
//
//   // return Future();
// }

}
