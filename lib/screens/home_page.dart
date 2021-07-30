import 'package:ajax/models/user.dart';
import 'package:ajax/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ajax/screens/main_screen/account_screen.dart';

import 'main_screen/account_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.user}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;
  final User user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<AjaxUser> _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = FirestoreService.instance.getUserByUid(widget.user.uid);
    FirestoreService.instance.getPayments(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.user.displayName);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: FutureBuilder<AjaxUser>(
        future: FirestoreService.instance.getUserByUid(widget.user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            throw("did not get user");
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return AccountPage(user: snapshot.data!);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
