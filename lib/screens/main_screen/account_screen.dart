import 'package:ajax/models/payment.dart';
import 'package:ajax/models/user.dart';
import 'package:ajax/screens/payment_screens/payment_screen.dart';
import 'package:ajax/services/api.dart';
import 'package:ajax/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key, required this.user}) : super(key: key);

  final AjaxUser user;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  int _counter = 0;
  late AjaxUser user = widget.user;
  late List<Payment> transactions;

  //     AjaxTransaction.getDummyTransactions();

  // configureListeners();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // user = widget.user;
    // configureListeners();
    // print("");
    // print("");
    // print("");
    // print("CALLING INITSTATE");
    FirestoreService.instance.getPayments(user.uid);
  }

  // void configureListeners() {
  //   //  firestore user listener
  //   FirebaseFirestore.instance
  //       .collection("User")
  //       .doc(user.uid)
  //       .snapshots()
  //       .listen((DocumentSnapshot snapshot) {
  //     print("document changed");
  //     // TODO investigate these shenanigans
  //     if (this.mounted) {
  //       setState(() {
  //         // print("trying to set the state");
  //         // print(snapshot);
  //
  //         user = AjaxUser.fromSnapshot(snapshot);
  //       });
  //     } else {
  //       // print("document changed but component not mounted");
  //     }
  //   });
  // }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _getUser() {
    FirestoreService.instance.getUserByUid(user.uid).then((newUser) {
      setState(() {
        user = newUser;
      });
    });
  }

  Future<void> _updatePayments() {
    return FirestoreService.instance.getPayments(user.uid).then((payments) {
      setState(() {
        transactions = payments;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<AjaxUser>(
          future: getAjaxUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              user = snapshot.data!;
              return Column(
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
                              backgroundImage: NetworkImage(user.pfpUrl),
                            ),
                          ),
                          SizedBox(height: 23),
                          Text(
                            "\$" + user.balance.toStringAsFixed(2),
                            style: Theme.of(context).textTheme.headline3,
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
                    child: FutureBuilder(
                      future: FirestoreService.instance.getPayments(user.uid),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Payment>> snapshot) {
                        if (snapshot.hasData) {
                          List<Payment>? transactions = snapshot.data;
                          if (transactions!.isEmpty) {
                            return Column(
                              children: [
                                Text(
                                  "No Transactions!",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _updatePayments();
                                  },
                                  child: Text("Refresh"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).accentColor,
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
                            onRefresh: _updatePayments,
                            child: ListView.builder(
                              itemCount: transactions.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  child: Card(
                                    color: Theme.of(context).accentColor,
                                    child: Text(
                                      transactions[index].message,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
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
                          margin: const EdgeInsets.only(bottom: 60, right: 0),
                          child: SizedBox(
                            // width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                print("button pressed");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentScreen(
                                            user: user,
                                          )),
                                  //  this empty setstate servers the purpose of resetting the user futurebuilder so the amount updates
                                ).then((value) => setState(() {
                                      print("SETTING STATE ON PAGE RETURN");
                                    }));
                              },
                              child: Text("Pay"),
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).accentColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

// Expanded(
// child: FutureBuilder(
// future: FirestoreService.instance.getPayments(user.uid),
// builder: (BuildContext context,
//     AsyncSnapshot<List<AjaxTransaction>> snapshot) {
// if (snapshot.hasData) {
// List<AjaxTransaction>? transactions = snapshot.data;
// return RefreshIndicator(
// onRefresh: () => FirestoreService.instance.getPayments(user.uid),
// child: ListView.builder(
// itemCount: transactions!.length,
// itemBuilder: (BuildContext context, int index) {
// return InkWell(
// child: Card(
// color: Theme.of(context).accentColor,
// child: Text(
// transactions[index].message,
// style: Theme.of(context).textTheme.subtitle1,
// ),
// ),
// );
// },
// ),
// );
// } else {
// return CircularProgressIndicator();
// }
// },
// ),
// ),
