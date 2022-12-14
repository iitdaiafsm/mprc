class UserModel {
  String? name;
  String? email;
  String? lastLogin;

  UserModel({this.name, this.email, this.lastLogin});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['last_login'] = lastLogin;
    return data;
  }
}
