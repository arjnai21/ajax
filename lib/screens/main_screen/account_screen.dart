import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grape/models/account.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _counter = 0;
  Account user = Account.getDummyAccount();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: SizedBox.expand(
              child: FractionallySizedBox(
                alignment: Alignment.topCenter,
                widthFactor: 1,
                heightFactor: .5,
                child: Stack(children: [
                  Container(
                    // color: Theme.of(context).primaryColor,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        color: Theme.of(context).primaryColor),
                  ),
                  Positioned.fill(
                    top: 45,
                    child: Column(
                      children: [
                        Align(
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: NetworkImage(user.pfpUrl),
                          ),
                        ),
                        SizedBox(height: 23),
                        Text("\$" + user.balance.toString(),
                          style: Theme.of(context).textTheme.headline3 ,)
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Text("hello", style: Theme.of(context).textTheme.bodyText1,),

          // Image.network(user.pfpUrl),
          // Spacer(flex: 1),

          // Spacer(flex: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 60, right: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print("button pressed");
                      },
                      child: Text("Pay or Request"),
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).accentColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          textStyle: Theme.of(context).textTheme.bodyText1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
