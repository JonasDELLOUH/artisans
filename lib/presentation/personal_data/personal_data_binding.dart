import 'package:artisans/presentation/personal_data/personal_data_controller.dart';
import 'package:get/get.dart';

class PersonalDataBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalDataController());
  }

}