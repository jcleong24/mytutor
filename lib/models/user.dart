class User {
  String? id;
  String? userName;
  String? userEmail;
  String? userPassword;
  String? userPassword2;
  String? userPhone;
  String? userAddress;

  User(
      {this.id,
      this.userName,
      this.userEmail,
      this.userPassword,
      this.userPassword2,
      this.userPhone,
      this.userAddress});

  User.fromJson(Map<String, dynamic> json) {
    id = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPassword = json['user_password'];
    userPassword2 = json['user_password2'];
    userPhone = json['user_phone'];
    userAddress = json['user_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = id;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['user_password'] = userPassword;
    data['user_password2'] = userPassword2;
    data['user_phone'] = userPhone;
    data['user_address'] = userAddress;
    return data;
  }
}
