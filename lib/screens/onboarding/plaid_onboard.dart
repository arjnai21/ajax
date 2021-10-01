import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:ajax/services/api.dart';

class PlaidOnboard extends StatefulWidget {
  const PlaidOnboard({Key? key}) : super(key: key);

  @override
  _PlaidOnboardState createState() => _PlaidOnboardState();
}



class _PlaidOnboardState extends State<PlaidOnboard> {
  @override
  void initState() {
    super.initState();
    configurePlaidLink();
  }

  void configurePlaidLink() async{
    String token =  await getPlaidLinkToken();
    print("PRINTING TOKEN");
    print(token);
    LinkConfiguration configuration = LinkTokenConfiguration(
      token: token,
    );
    PlaidLink _plaidLink = PlaidLink(
      configuration: configuration,
      onSuccess: _onSuccessCallback,
      onEvent: _onEventCallback,
      onExit: _onExitCallback,
    );


    _plaidLink.open();
  }

  void _onSuccessCallback(String publicToken, LinkSuccessMetadata metadata) {
    exchangePublicToken(publicToken);
    // TODO figure out how to get to the next screen
    // TODO probably just Navigator the jaunt but we'll see what happens
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
  }

  void _onEventCallback(String event, LinkEventMetadata metadata) {
    print("onEvent: $event, metadata: ${metadata.description()}");
  }

  void _onExitCallback(LinkError? error, LinkExitMetadata metadata) {
    print("onExit metadata: ${metadata.description()}");

    if (error != null) {
      print("onExit error: ${error.description()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign in with Plaid"),),
      body: Center(
        child: Text("THIS SHOULD BE IN THE BACKGROUND OF PLAID LINK??"),
      ),
    );
  }
}
