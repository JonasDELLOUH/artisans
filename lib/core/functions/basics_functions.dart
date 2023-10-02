
import 'package:url_launcher/url_launcher.dart';

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

void callPhoneNumber(String phoneNumber) async {
  var url = 'tel://$phoneNumber';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Error Occurred';
  }
}

void openWhatsAppChat(String phoneNumber) async {
  var whatsappUrl = "https://wa.me/$phoneNumber";
  if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
    await launchUrl(Uri.parse(whatsappUrl));
  } else {
    throw 'Impossible d\'ouvrir WhatsApp.';
  }
}
