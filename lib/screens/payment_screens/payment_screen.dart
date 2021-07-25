import 'package:ajax/models/user.dart';
import 'package:ajax/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({Key? key, required this.user}) : super(key: key);

  final AjaxUser user;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  late AjaxUser user = widget.user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("hello"),
      ),
      body: SendMoneyForm(user: user),
    );
  }
}

// Define a custom Form widget.
class SendMoneyForm extends StatefulWidget {
  SendMoneyForm({Key? key, required this.user}) : super(key: key);

  final AjaxUser user;


  @override
  SendMoneyFormState createState() {
    return SendMoneyFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class SendMoneyFormState extends State<SendMoneyForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  late AjaxUser user = widget.user;
  TextEditingController _recipientController = new TextEditingController();
  TextEditingController _amountController = new TextEditingController();
  TextEditingController _messageController = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            "Recipient",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          TextFormField(
            controller: _recipientController,
            keyboardAppearance: Brightness.dark,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter recipient';
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter Recipient",
              fillColor: Colors.white,
              filled: true,
            ),
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "Amount",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            keyboardAppearance: Brightness.dark,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter amount';
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter Amount",
              fillColor: Colors.white,
              filled: true,
            ),
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "Message",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          TextFormField(
            controller: _messageController,
            keyboardType: TextInputType.text,
            keyboardAppearance: Brightness.dark,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter message';
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter Message",
              fillColor: Colors.white,
              filled: true,
            ),
            style: TextStyle(color: Colors.black),
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                String recipient = _recipientController.text;
                num amount = double.parse(_amountController.text);
                String message = _messageController.text;
                FirestoreService.instance.makePayment(user.uid, user.uid, amount);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Sent Money')));
                Navigator.pop(context);

              }
            },
            child: Text('Submit'),
          ),
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }

  void dispose(){
    _recipientController.dispose();
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();

  }
}
