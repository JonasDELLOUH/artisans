class UserModel {
  final String userId;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final bool hasSalon;
  final String tel;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.tel,
    required this.hasSalon,
    required this.firstname,
    required this.lastname,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        userId: json["_id"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        tel: json["tel"] ?? "",
        hasSalon: json["hasSalon"] ?? false,
        firstname: json["firstname"] ?? "",
        lastname: json["lastname"] ?? "");
  }

  Map<String, dynamic> toJson(){
    return {
      "_id": userId,
      "username": username,
      "email": email,
      "tel": tel,
      "hasSalon": hasSalon,
      "firstname": firstname,
      "lastname": lastname
    };
  }

  static List<UserModel> fromJsonList(List<dynamic> json) {
    return json.map((userModel) => UserModel.fromJson(userModel)).toList();
  }
}