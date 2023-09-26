class ChangePasswordData {
  String message = "";

  ChangePasswordData.fromJson(Map<String, dynamic> json) {
    message = json["message"] ?? "";
  }
}