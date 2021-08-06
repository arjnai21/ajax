import 'package:ajax/screens/main_screen/account_screen.dart';
import 'package:ajax/services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:hello_world/myHomePage.dart';
import '../services/auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Sign in to ajax')), body: Body());
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late User user;

  @override
  void initState() {
    super.initState();
    // signOutGoogle();
  }

  void click() {
    signInWithGoogle().then((user)  {
      // getUser();
      this.user = user!;
      getAjaxUser().then((user){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AccountPage()));
      });


    });

  }

  Widget googleLoginButton() {
    return OutlineButton(
        onPressed: this.click,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        splashColor: Colors.grey,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/google_logo.png'), height: 35),
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Sign in with Google',
                        style: TextStyle(color: Colors.grey, fontSize: 25)))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.center, child: googleLoginButton());
  }
}