import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/firestore_constants.dart';

class FirebaseServices{

  final FirebaseFirestore firebaseFirestore;

  FirebaseServices({required this.firebaseFirestore});

  Future<void> updateFirestoreData(
      String collectionPath, String path, Map<String, dynamic> updateData) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(updateData);
  }

  Stream<QuerySnapshot> getChatContacts(String userId) {
    final controller = StreamController<QuerySnapshot>();

    final queryFrom = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .where(FirestoreConstants.idFrom, isEqualTo: userId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .snapshots();

    final queryTo = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .where(FirestoreConstants.idTo, isEqualTo: userId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .snapshots();

    queryFrom.listen((querySnapshot) async {
      final userIds = <String>{};

      for (final doc in querySnapshot.docs) {
        final idTo = doc[FirestoreConstants.idTo] as String;

        if (idTo != userId) {
          userIds.add(idTo);
        }
      }

      if (userIds.isNotEmpty) {
        final usersDocs = await firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, whereIn: userIds.toList())
            .get();

        controller.sink.add(usersDocs);
      }
    });

    queryTo.listen((querySnapshot) async {
      final userIds = <String>{};

      for (final doc in querySnapshot.docs) {
        final idFrom = doc[FirestoreConstants.idFrom] as String;

        if (idFrom != userId) {
          userIds.add(idFrom);
        }

      }

      if (userIds.isNotEmpty) {
        final usersDocs = await firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, whereIn: userIds.toList())
            .get();

        controller.sink.add(usersDocs);
      }
    });

    return controller.stream;
  }


  Stream<QuerySnapshot> getFirestoreData(
      String collectionPath, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == true) {
      return firebaseFirestore
          .collection(collectionPath)
          .limit(limit)
          .where(FirestoreConstants.displayName, isEqualTo: textSearch)
          .snapshots();
    } else {
      return firebaseFirestore
          .collection(collectionPath)
          .limit(limit)
          .snapshots();
    }
  }
}