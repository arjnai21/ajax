class Payment{
  String sender = "";
  String recipient = "";
  num amount = 0;
  String message = "";
  late DateTime timestamp;


  Payment(this.sender, this.recipient, this.amount, this.message,
      this.timestamp);

  Payment.fromJson(Map<String, dynamic> json){
    sender = json["sender_email"];
    recipient = json["recipient_email"];
    amount = json["amount"];
    message = json["message"];
    timestamp = DateTime.parse(json["timestamp"]).toLocal();

  }

}

