import 'package:ajax/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{

  static Future<AjaxUser> getUserByUid(uid){
    print("getting user by uid");
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("User");
    return users.doc(uid).get().then((data){
      print("got document");
      dynamic userData = data.data();
      print(userData);
      AjaxUser user = AjaxUser(uid, userData["displayName"], userData["email"], userData["balance"], userData["photoURL"]);
      return user;
    });
  }


}