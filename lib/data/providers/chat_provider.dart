import 'dart:async';
import 'dart:io';

import 'package:artisans/core/models/message_model.dart';
import 'package:artisans/core/models/salon_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rx;

import '../../core/constants/firestore_constants.dart';
import '../../core/models/user_model.dart';

class ChatProvider {
  // final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ChatProvider(
      {required this.firebaseStorage, required this.firebaseFirestore});

  UploadTask uploadImageFile(File image, String filename) {
    Reference reference = firebaseStorage.ref().child(filename);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateFirestoreData(
      String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataUpdate);
  }

  Stream<QuerySnapshot> getChatMessage(String groupChatId, int limit) {
    return firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  Stream<QuerySnapshot> getChatMessages(String userId1, String userId2, {int limit = 20}) {
    final messageRef =
    firebaseFirestore.collection(FirestoreConstants.pathMessageCollection);

    final query1 = messageRef
        .where(FirestoreConstants.idFrom, isEqualTo: userId1)
        .where(FirestoreConstants.idTo, isEqualTo: userId2)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();

    final query2 = messageRef
        .where(FirestoreConstants.idFrom, isEqualTo: userId2)
        .where(FirestoreConstants.idTo, isEqualTo: userId1)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();

    Stream<QuerySnapshot> combinedStream = rx.Rx.merge([query1, query2]).map((querySnapshot) {
      // Triez les documents par ordre chronologique décroissant
      final sortedDocs = querySnapshot.docs.toList()
        ..sort((a, b) => b[FirestoreConstants.timestamp].compareTo(a[FirestoreConstants.timestamp]));

      // Retournez la QuerySnapshot triée
      querySnapshot.docs.assignAll(sortedDocs);
      return querySnapshot;
    });

    return combinedStream;
  }

  // void sendChatMessage(String content, int type, String groupChatId,
  //     String currentUserId, String peerId) {
  //   DocumentReference documentReference = firebaseFirestore
  //       .collection(FirestoreConstants.pathMessageCollection)
  //       .doc(groupChatId)
  //       .collection(groupChatId)
  //       .doc(DateTime.now().millisecondsSinceEpoch.toString());
  //   MessageModel chatMessages = MessageModel(
  //       idFrom: currentUserId,
  //       idTo: peerId,
  //       timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
  //       content: content,
  //       type: type);
  //
  //   FirebaseFirestore.instance.runTransaction((transaction) async {
  //     transaction.set(documentReference, chatMessages.toJson());
  //   });
  // }



  Future<void> sendMessage(
      {required String idFrom,
        required String idTo,
        required String content,
        required int type,
        SalonModel? salonModel,
        UserModel? userModel,
        bool isSalon = false}) async {
    final messageRef =
    firebaseFirestore.collection(FirestoreConstants.pathMessageCollection);

    // Créer un nouveau document pour le salon ou l'utilisateur cible s'il n'existe pas
    await _createUserIfNotExists(idTo,
        salonModel: salonModel, userModel: userModel, isSalon: isSalon);
    await _createUserIfNotExists(idFrom, salonModel: salonModel, userModel: userModel, isSalon: isSalon);

    // Créez un objet de données de message avec les détails requis
    final chatMessages = MessageModel(
      idFrom: idFrom,
      idTo: idTo,
      content: content,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
    );

    // Obtenez une référence au document de message
    final documentReference = messageRef.doc();

    // Utilisez une transaction pour créer le message de manière atomique
    await firebaseFirestore.runTransaction((transaction) async {
      transaction.set(documentReference, chatMessages.toJson());
    });
  }


  Future<void> _createUserIfNotExists(String userId,
      {SalonModel? salonModel,
      UserModel? userModel,
      bool isSalon = false}) async {
    final userRef =
        firebaseFirestore.collection(FirestoreConstants.pathUserCollection);
    final userDoc = await userRef.doc(userId).get();

    if (!userDoc.exists) {
      // Créer un utilisateur avec les informations par défaut
      final userData = _generateDefaultUserData(userId,
          salonModel: salonModel, userModel: userModel, isSalon: isSalon);
      await userRef.doc(userId).set(userData);
    }
  }

  Map<String, dynamic> _generateDefaultUserData(String userId,
      {SalonModel? salonModel, UserModel? userModel, bool isSalon = false}) {
    return isSalon
        ? {
            FirestoreConstants.id: salonModel?.salonId,
            FirestoreConstants.displayName: salonModel?.salonName,
            FirestoreConstants.email: salonModel?.email ?? "",
            FirestoreConstants.phoneNumber: salonModel?.phone ?? "",
            FirestoreConstants.photoUrl: salonModel?.imageUrl ?? "",
            FirestoreConstants.isSalon: true
          }
        : {
            FirestoreConstants.id: userModel?.userId,
            FirestoreConstants.displayName: userModel?.username,
            FirestoreConstants.email: userModel?.email ?? "",
            FirestoreConstants.phoneNumber: userModel?.tel ?? "",
            FirestoreConstants.photoUrl: "",
            FirestoreConstants.isSalon: false
          };
  }
}

class MessageType {
  static const text = 0;
  static const image = 1;
  static const sticker = 2;
}
