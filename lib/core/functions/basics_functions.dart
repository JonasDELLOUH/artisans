
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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

String formatDurationFromNow(String date) {
  final now = DateTime.now();
  final parsedDate = DateTime.parse(date);

  final difference = now.difference(parsedDate);

  try{
    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years > 1 ? "${'year'.tr}s" : 'year'.tr}';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months > 1 ? 'month'.tr : 'month'.tr}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays > 1 ? "${'day'.tr}s" : 'day'.tr}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours > 1 ? "${'hour'.tr}s" : 'hour'.tr}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes > 1 ? "${'minute'.tr}s" : 'minute'.tr}';
    } else {
      return 'now'.tr;
    }
  } catch(e){
    debugPrint("$e");
    return "";
  }
}
