import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_constants.dart';

class MessageModel {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;

  MessageModel(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.type});

  Map<String, dynamic> toJson() {
    return {
      FirestoreConstants.idFrom: idFrom,
      FirestoreConstants.idTo: idTo,
      FirestoreConstants.timestamp: timestamp,
      FirestoreConstants.content: content,
      FirestoreConstants.type: type,
    };
  }

  factory MessageModel.fromDocument(DocumentSnapshot documentSnapshot) {
    String idFrom = documentSnapshot.get(FirestoreConstants.idFrom);
    String idTo = documentSnapshot.get(FirestoreConstants.idTo);
    String timestamp = documentSnapshot.get(FirestoreConstants.timestamp);
    String content = documentSnapshot.get(FirestoreConstants.content);
    int type = documentSnapshot.get(FirestoreConstants.type);

    return MessageModel(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type);
  }
}
