import 'package:artisans/core/colors/colors.dart';
import 'package:artisans/core/routes/app_routes.dart';
import 'package:artisans/presentation/single_chat/single_chat_screen.dart';
import 'package:artisans/widgets/custom_text.dart';
import 'package:artisans/presentation/chats/chats_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import '../../core/constants/firestore_constants.dart';
import '../../core/constants/size_constants.dart';
import '../../core/models/chat_user.dart';
import '../../core/utils/keyboard_utils.dart';
import 'widgets/chat.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({Key? key, required this.controller}) : super(key: key);

  ChatsController controller = Get.find<ChatsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const CustomText(
                      text: "Chats", fontSize: 30, fontWeight: FontWeight.bold),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 2, bottom: 2),
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pink[50],
                    ),
                    child: const Row(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Colors.pink,
                          size: 20,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        CustomText(
                            text: "New",
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // buildSearchBar(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              // stream: controller.firebaseServices.getFirestoreData(
              //     FirestoreConstants.pathUserCollection,
              //     controller.limit,
              //     controller.textSearch.value),
              stream: controller.firebaseServices.getChatContacts(
                  controller.appServices.currentUser.value?.hasSalon ?? false
                      ? controller.appServices.currentSalon.value?.salonId ?? ""
                      : controller.appServices.currentUser.value?.userId ?? "", ),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if ((snapshot.data?.docs.length ?? 0) > 0) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) =>
                          buildItem(context, snapshot.data?.docs[index]),
                      controller: controller.scrollController,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    );
                  } else {
                    return const Center(
                      child: Text('No user found...'),
                    );
                  }
                } else {
                  return const Center(
                    child: Text('No user found...'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(Sizes.dimen_10),
      height: Sizes.dimen_50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.dimen_30),
        color: blueColor.withOpacity(0.8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: Sizes.dimen_10,
          ),
          const Icon(
            Icons.person_search,
            color: Color(0xFFf5f5f5),
            size: Sizes.dimen_24,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: TextFormField(
              textInputAction: TextInputAction.search,
              controller: controller.searchTextEditingController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.buttonClearController.add(true);
                  controller.textSearch.value = value;
                } else {
                  controller.buttonClearController.add(false);
                  controller.textSearch.value = "";
                }
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Search here...',
                hintStyle: TextStyle(color: Color(0xFFf5f5f5)),
              ),
            ),
          ),
          StreamBuilder(
              stream: controller.buttonClearController.stream,
              builder: (context, snapshot) {
                return snapshot.data == true
                    ? GestureDetector(
                        onTap: () {
                          controller.searchTextEditingController.clear();
                          controller.buttonClearController.add(false);
                          controller.textSearch.value = '';
                        },
                        child: const Icon(
                          Icons.clear_rounded,
                          color: Color(0xffaeaeae),
                          size: 20,
                        ),
                      )
                    : const SizedBox.shrink();
              })
        ],
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot? documentSnapshot) {
    // final firebaseAuth = FirebaseAuth.instance;
    if (documentSnapshot != null) {
      ChatUser userChat = ChatUser.fromDocument(documentSnapshot);
      if (userChat.id == controller.appServices.currentUser.value?.userId) {
        return const SizedBox.shrink();
      } else {
        return TextButton(
          onPressed: () {
            if (KeyboardUtils.isKeyboardShowing()) {
              KeyboardUtils.closeKeyboard(context);
            }
            // Get.toNamed("${AppRoutes.singleChatRoute}/${userChat.id}",
            //     arguments: [
            //       userChat.id,
            //       userChat.displayName,
            //       userChat.photoUrl,
            //       ""
            //     ]);
          },
          child: ListTile(
            leading: userChat.photoUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(Sizes.dimen_30),
                    child: Image.network(
                      userChat.photoUrl,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      loadingBuilder: (BuildContext ctx, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                                color: Colors.grey,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null),
                          );
                        }
                      },
                      errorBuilder: (context, object, stackTrace) {
                        return const Icon(Icons.account_circle, size: 50);
                      },
                    ),
                  )
                : userChat.displayName.isNotEmpty
                    ? CircleAvatar(
                        radius: 22.0,
                        backgroundColor: blueColor,
                        child: CustomText(
                          fontSize: 15,
                          text: (userChat.displayName
                              .substring(0, 1)
                              .toUpperCase()),
                          color: whiteColor,
                        ),
                      )
                    : const Icon(
                        Icons.account_circle,
                        size: 50,
                      ),
            title: Text(
              userChat.displayName,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
