import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:images_picker/images_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
class AddPostController extends GetxController{
  final RoundedLoadingButtonController btnController =
  RoundedLoadingButtonController();
  RxBool isPost = true.obs;

  Future getImage() async {
    ImagesPicker.pick(
      language: Language.English,
    );
  }
}