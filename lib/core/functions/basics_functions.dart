
bool isEmailValid(String value) {
  // Expression régulière pour vérifier si c'est un email valide
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  return emailRegex.hasMatch(value);
}

bool isPhoneNumberValid(String value) {
  // Expression régulière pour vérifier si c'est un numéro de téléphone valide
  final phoneRegex = RegExp(r'^[0-9]{8}$');

  return phoneRegex.hasMatch(value);
}