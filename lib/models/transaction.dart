class AjaxTransaction{
  String _sender = "";
  String _recipient = "";
  num _amount = 0;
  String message = "";
  late DateTime timestamp;


  AjaxTransaction(this._sender, this._recipient, this._amount, this.message,
      this.timestamp);

  AjaxTransaction.fromSnapshot(snapshot){
    _sender = snapshot["senderUid"];
    _recipient = snapshot["recipientUid"];
    _amount = snapshot["amount"];
    message = snapshot["message"];
    timestamp = snapshot["timestamp"].toDate();

  }

  static getDummyTransactions(){
    return [
      AjaxTransaction("Arjun", "Wilbert", 200, "hello", DateTime.utc(1969, 7, 20, 20, 18, 04)),
      AjaxTransaction("Arjun", "Wilbert", 200, "hello", DateTime.utc(1969, 7, 20, 20, 18, 04)),
      AjaxTransaction("Arjun", "Wilbert", 200, "hello", DateTime.utc(1969, 7, 20, 20, 18, 04)),

    ];
  }
}

