import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("hello"),
      ),
      body: SendMoneyForm(),
    );
  }
}

// Define a custom Form widget.
class SendMoneyForm extends StatefulWidget {
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
            keyboardType: TextInputType.number,
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
              labelText: "Enter Message",
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
            keyboardType: TextInputType.number,
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
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));
              }
            },
            child: Text('Submit'),
          ),
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}
