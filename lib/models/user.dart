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

  static getDummyAccount() {
    return AjaxUser("123456", "anair123", "arjun@nairsnet.com", 21.87,
        "https://dw3jhbqsbya58.cloudfront.net/rosters/a9cbf684-16ef-4997-9539-15fefe9df410/e/5/5/e55dc629-91aa-ea11-80ce-a444a33a3a97/thumbnail.jpg?version=637389721377004039");
  }
}
