import 'package:ajax/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



Future<AjaxUser> getAjaxUser()async{
  User? currentUser = FirebaseAuth.instance.currentUser;
  return currentUser!.getIdToken().then((token) async {
    var url = Uri.parse('https://us-central1-ajax-b5934.cloudfunctions.net/api/getUser');
    var response = await http.post(url, body: {"uid": currentUser.uid},headers: {"Authorization": "Bearer " + token});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print(json.decode(response.body));
    print(json.decode(response.body)["display_name"]);
    return AjaxUser.fromJson(json.decode(response.body));
  });

}

void callApi (url, params){
  User? currentUser = FirebaseAuth.instance.currentUser;
}

  
