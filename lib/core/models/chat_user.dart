import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../constants/firestore_constants.dart';

class ChatUser extends Equatable {
  final String id;
  final String photoUrl;
  final String displayName;
  final String phoneNumber;
  final String aboutMe;
  final String email;

  const ChatUser(
      {required this.id,
        required this.email,
      required this.photoUrl,
      required this.displayName,
      required this.phoneNumber,
      required this.aboutMe});

  ChatUser copyWith({
    String? id,
    String? photoUrl,
    String? nickname,
    String? phoneNumber,
    String? email,
  }) =>
      ChatUser(
        email: "",
          id: id ?? this.id,
          photoUrl: photoUrl ?? this.photoUrl,
          displayName: nickname ?? displayName,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          aboutMe: email ?? aboutMe);

  Map<String, dynamic> toJson() => {
        FirestoreConstants.displayName: displayName,
        FirestoreConstants.photoUrl: photoUrl,
        FirestoreConstants.phoneNumber: phoneNumber,
        FirestoreConstants.aboutMe: aboutMe,
      };

  factory ChatUser.fromDocument(DocumentSnapshot snapshot) {
    String photoUrl = "";
    String displayName = "";
    String phoneNumber = "";
    String email = "";

    try {
    email = snapshot.get(FirestoreConstants.email);
      photoUrl = snapshot.get(FirestoreConstants.photoUrl);
    displayName = snapshot.get(FirestoreConstants.displayName);
      phoneNumber = snapshot.get(FirestoreConstants.phoneNumber);
      // aboutMe = snapshot.get(FirestoreConstants.aboutMe);
      // debugPrint("nickname : $nickname");

    } catch (e) {
      debugPrint("ChatUser.fromDocument error: $e");
    }
    return ChatUser(
        id: snapshot.id,
        photoUrl: photoUrl,
        displayName: displayName,
        phoneNumber: phoneNumber,
        email: email,
        aboutMe: "aboutMe");
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, photoUrl, displayName, phoneNumber, aboutMe];
}
