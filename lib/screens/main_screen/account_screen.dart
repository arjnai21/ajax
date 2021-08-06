import 'package:ajax/models/payment.dart';
import 'package:ajax/models/user.dart';
import 'package:ajax/screens/login.dart';
import 'package:ajax/screens/payment_screens/payment_screen.dart';
import 'package:ajax/services/api.dart';
import 'package:ajax/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _counter = 0;

  // late AjaxUser user;
  late List<Payment> transactions;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  //     AjaxTransaction.getDummyTransactions();

  // configureListeners();

  Future<void> initTransactions() {
    return getPayments().then((payments) {
      transactions = payments;
    });
  }

  Future<void> refreshTransactions() {
    return getPayments().then((payments) {
      setState(() {
        transactions = payments;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        child: Container(
          color: Theme.of(context).accentColor,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Sign out'),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  signOutGoogle();
                  // setState(() {
                  //
                  // });
                  // Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => LoginPage()));
                  // Update the state of the app.
                  // ...
                },
              ),
              // ListTile(
              //   title: const Text('Item 2'),
              //   onTap: () {
              //     // Update the state of the app.
              //     // ...
              //   },
              // ),
            ],
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<AjaxUser>(
            //TODO properly handle lack of internet and double refreshing of transactions
            future: getAjaxUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AjaxUser user = snapshot.data!;
                print("snapshot has data and is building ");
                print(snapshot.data);
                return Stack(
                  children: [
                    Center(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceA,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(children: [
                            Container(
                              height: MediaQuery.of(context).size.height *
                                  .45, //constraints.maxHeight * .5,

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
                                      backgroundImage:
                                          NetworkImage(user.pfpUrl),
                                    ),
                                  ),
                                  SizedBox(height: 23),
                                  Text(
                                    "\$" + user.balance.toStringAsFixed(2),
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  )
                                ],
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 10,
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Transactions",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),

                          // Padding(padding: EdgeInsets.all(5)),
                          Expanded(
                            child: FutureBuilder<void>(
                              future: initTransactions(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  // List<Payment>? transactions = snapshot.data;
                                  if (transactions.isEmpty) {
                                    return Column(
                                      children: [
                                        Text(
                                          "No Transactions!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          child: Text("Refresh"),
                                          style: ElevatedButton.styleFrom(
                                              primary:
                                                  Theme.of(context).accentColor,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 20),
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                        ),
                                      ],
                                    );
                                  }
                                  return RefreshIndicator(
                                    onRefresh: refreshTransactions,
                                    child: ListView.builder(
                                      itemCount: transactions.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          child: Card(
                                            color:
                                                Theme.of(context).accentColor,
                                            child: Text(
                                              transactions[index].message,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            ),
                          ),

                          // Image.network(user.pfpUrl),
                          // Spacer(flex: 1),

                          // Spacer(flex: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 60, right: 0),
                                  child: SizedBox(
                                    // width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentScreen(
                                                    user: user,
                                                  )),
                                          //  this empty setstate servers the purpose of resetting the user futurebuilder so the amount updates
                                        ).then((value) => setState(() {}));
                                      },
                                      child: Text("Pay"),
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Theme.of(context).accentColor,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 30,
                      child: ClipOval(
                        child: Material(
                          color: Theme.of(context).accentColor, // Button color
                          child: InkWell(
                            splashColor:
                                Theme.of(context).primaryColor, // Splash color
                            onTap: () =>
                                scaffoldKey.currentState!.openEndDrawer(),
                            child: SizedBox(
                                width: 56, height: 56, child: Icon(Icons.menu)),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              else if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();

              }
              else {
                return Center(child: Text("Unable to get transactions. Please check internet connection", style: Theme.of(context).textTheme.subtitle1,),);
                throw Exception("Unable to get transactions. Check internet connection.");
              }
            }),
      ),
    );
  }
}
