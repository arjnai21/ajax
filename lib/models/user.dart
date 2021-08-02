class AjaxUser {
  String uid = "";
  String username = "";
  String emailAddress = "";
  num balance = 0;
  String pfpUrl = "";

  AjaxUser(
      this.uid, this.username, this.emailAddress, this.balance, this.pfpUrl);

  AjaxUser.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    username = json["display_name"];
    emailAddress = json["email"];
    balance = json["balance"];
    pfpUrl = json["photo_url"];
  }

}
