import 'package:get/get.dart';

import 'en_us.dart';
import 'fr_fr.dart';

class Languages extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {'fr_FR': frFr, 'en_US': enUS};

}