import 'package:ajax/models/payment.dart';
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
      // dynamic userData = data.data();
      // print(userData);
      AjaxUser user = AjaxUser.fromSnapshot(data);
      return user;
    });
  }

  Future<void> makePayment(
      String senderUid, String recipientUid, num amount, message) async {
    // Future<void> getFruit() async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('makePayment');
    callable({
      "senderUid": senderUid,
      "recipientUid": recipientUid,
      "amount": amount,
      "message": message,
    }).then((response){
      print(response.data);
    });
    // List fruit =
    //     results.data; // ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"]
    // }
  }

  Future<List<Payment>> getPayments(String uid) async {
    var sentTransactionSnapshots = await firestore.collection("Payment").where("senderUid",  isEqualTo: uid).orderBy("timestamp").get();
    List<Payment> sentTransactions = sentTransactionSnapshots.docs.map((snapshot) => Payment.fromSnapshot(snapshot)).toList();
    // print(sentTransactions[1].message);
    var receivedTransactionSnapshots = await firestore.collection("Payment").where("recipientUid",  isEqualTo: uid).orderBy("timestamp").get();
    List<Payment> receivedTransactions = receivedTransactionSnapshots.docs.map((snapshot) => Payment.fromSnapshot(snapshot)).toList();
    //merge transactions here
    // print(receivedTransactions[1].message);
    print(receivedTransactions);


    return sentTransactions + receivedTransactions;

    print(sentTransactions);
    // print(sentTransactions[0].data());
    // return sentTransactions.map((snapshot) => AjaxTransaction.fromSnapshot(snapshot)).toList();
    // print(sentPayments.docs);

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
