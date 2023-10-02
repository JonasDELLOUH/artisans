import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/firestore_constants.dart';
import '../../core/services/app_services.dart';
import '../../data/providers/chat_provider.dart';

class SingleChatController extends GetxController {
  final appServices = Get.find<AppServices>();
  late String currentUserId;

  String peerId = "";
  String peerAvatar = "";
  String peerNickname = "";
  String userAvatar = "";
  String groupChatId = '';

  ChatProvider chatProvider = ChatProvider(
      firebaseFirestore: FirebaseFirestore.instance,
      firebaseStorage: FirebaseStorage.instance);

  List<QueryDocumentSnapshot> listMessages = [];

  int limit = 20;
  final int limitIncrement = 20;

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void onInit() {
    peerId = Get.arguments[0] ?? "";
    peerNickname = Get.arguments[1] ?? "";
    peerAvatar = Get.arguments[2] ?? "";
    userAvatar = Get.arguments[3] ?? "";
    super.onInit();
    currentUserId = appServices.currentUser.value?.userId ?? "";
    focusNode.addListener(onFocusChanged);
    scrollController.addListener(_scrollListener);
    readLocal();
  }

  void readLocal() {
    if (appServices.currentUser.value?.userId.isNotEmpty == true) {
      currentUserId = appServices.currentUser.value?.userId ?? "";
    } else {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => const LoginPage()),
      //         (Route<dynamic> route) => false);
    }
    if (currentUserId.compareTo(peerId) > 0) {
      groupChatId = '$currentUserId - $peerId';
    } else {
      groupChatId = '$peerId - $currentUserId';
    }
    chatProvider.updateFirestoreData(FirestoreConstants.pathUserCollection,
        currentUserId, {FirestoreConstants.chattingWith: peerId});
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      // setState(() {
      limit += limitIncrement;
      // });
    }
  }

  void onFocusChanged() {
    if (focusNode.hasFocus) {
      // setState(() {
      isShowSticker = false;
      // });
    }
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        // setState(() {
        isLoading = true;
        // });
        uploadImageFile();
      }
    }
  }

  void getSticker() {
    focusNode.unfocus();
    // setState(() {
    isShowSticker = !isShowSticker;
    // });
  }

  Future<bool> onBackPressed() {
    if (isShowSticker) {
      // setState(() {
      isShowSticker = false;
      // });
    } else {
      chatProvider.updateFirestoreData(FirestoreConstants.pathUserCollection,
          currentUserId, {FirestoreConstants.chattingWith: null});
    }
    return Future.value(false);
  }

  void callPhoneNumber(String phoneNumber) async {
    var url = 'tel://$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Error Occurred';
    }
  }

  void uploadImageFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = chatProvider.uploadImageFile(imageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      // setState(() {
      isLoading = false;
      onSendMessage(imageUrl, MessageType.image);
      // });
    } on FirebaseException catch (e) {
      // setState(() {
      isLoading = false;
      // });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatProvider.sendMessage(
          content: content,
          type: type,
          idFrom: appServices.hasSalon.value
              ? appServices.currentSalon.value?.salonId ?? ""
              : appServices.currentUser.value?.userId ?? "",
          idTo: peerId);
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: Colors.grey);
    }
  }

  // checking if received message
  bool isMessageReceived(int index) {
    if ((index > 0 &&
            listMessages[index - 1].get(FirestoreConstants.idFrom) ==
                currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  // checking if sent message
  bool isMessageSent(int index) {
    if ((index > 0 &&
            listMessages[index - 1].get(FirestoreConstants.idFrom) !=
                currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }
}
