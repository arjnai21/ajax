class Payment{
  String sender = "";
  String recipient = "";
  num amount = 0;
  String message = "";
  late DateTime timestamp;


  Payment(this.sender, this.recipient, this.amount, this.message,
      this.timestamp);

  Payment.fromSnapshot(snapshot){
    sender = snapshot["senderUid"];
    recipient = snapshot["recipientUid"];
    amount = snapshot["amount"];
    message = snapshot["message"];
    timestamp = snapshot["timestamp"].toDate();

  }

  static getDummyTransactions(){
    return [
      Payment("Arjun", "Wilbert", 200, "hello", DateTime.utc(1969, 7, 20, 20, 18, 04)),
      Payment("Arjun", "Wilbert", 200, "hello", DateTime.utc(1969, 7, 20, 20, 18, 04)),
      Payment("Arjun", "Wilbert", 200, "hello", DateTime.utc(1969, 7, 20, 20, 18, 04)),

    ];
  }
}

