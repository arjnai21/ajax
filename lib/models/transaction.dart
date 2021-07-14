class Transaction{
  String _sender = "";
  String _recipient = "";
  double _amount = 0;
  String message = "";
  late DateTime timestamp;


  Transaction(this._sender, this._recipient, this._amount, this.message,
      this.timestamp);

  static getDummyTransactions(){
    return [
      Transaction("Arjun", "Wilbert", 200, "hello", DateTime.utc(1969, 7, 20, 20, 18, 04)),
      Transaction("Arjun", "Wilbert", 200, "hello", DateTime.utc(1969, 7, 20, 20, 18, 04)),
      Transaction("Arjun", "Wilbert", 200, "hello", DateTime.utc(1969, 7, 20, 20, 18, 04)),

    ];
  }
}

