import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gugu/app/call-services/domain/entity/call-entity.dart';
import 'package:gugu/app/call-services/domain/repository/call-services-repository.dart';
import 'package:gugu/core/utility/db-keys.dart';

class CallServieRepositoryImpl extends CallServicesRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<void> endCall({required String userID}) async {
    await _firebaseFirestore
        .collection(DBKeys.collectionNameActiveCalls)
        .doc(userID)
        .delete();
  }

  @override
  Future<void> makeCall({required CallEntity callEntity}) async {
    await _firebaseFirestore
        .collection(DBKeys.collectionNameActiveCalls)
        .doc(callEntity.dialer.id)
        .set(CallEntity.toMap(callEntity: callEntity));
    await _firebaseFirestore
        .collection(DBKeys.collectionNameActiveCalls)
        .doc(callEntity.receiver.id)
        .set(CallEntity.toMap(callEntity: callEntity));
  }

  @override
  Future<Stream<CallEntity>> getCallListener() async {
    final StreamController<CallEntity> streamController =
        new StreamController();
    try {
      _firebaseFirestore
          .collection(DBKeys.collectionNameActiveCalls)
          .doc(_firebaseAuth.currentUser!.uid)
          .snapshots()
          .listen(
        (event) async {
          if (event.exists) {
            bool isReceiver = _firebaseAuth.currentUser!.uid ==
                    event.data()![DBKeys.keyNameReceiverID]
                ? true
                : false;
            CallEntity callEntity = await CallEntity.fromMap(
                data: event.data()!, isReceiver: isReceiver);
            streamController.add(callEntity);
          }
        },
      );
    } catch (error) {
      streamController.close();
    }
    return streamController.stream;
  }
}
