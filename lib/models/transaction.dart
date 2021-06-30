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
      // new Transaction(),
      // new Transaction(),
      // new Transaction(),
    ];
  }
}

