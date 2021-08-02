class Payment{
  String sender = "";
  String recipient = "";
  num amount = 0;
  String message = "";
  late DateTime timestamp;


  Payment(this.sender, this.recipient, this.amount, this.message,
      this.timestamp);

  Payment.fromJson(Map<String, dynamic> json){
    sender = json["sender_id"];
    recipient = json["recipient_id"];
    amount = json["amount"];
    message = json["message"];
    timestamp = DateTime.parse(json["timestamp"]).toLocal();

  }

}

