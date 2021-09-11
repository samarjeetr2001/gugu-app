import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gugu/app/call-services/domain/entity/call-entity.dart';
import 'package:gugu/app/call-services/domain/repository/call-services-repository.dart';
import 'package:gugu/core/utility/db-keys.dart';
import 'package:gugu/core/utility/enums.dart';
import 'package:gugu/core/utility/keys.dart';

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

  @override
  Future<Stream<CallStatus>> connectCall(
      {required String userID,
      required String callID,
      required CallType callType}) async {
    final StreamController<CallStatus> streamController =
        new StreamController();
    try {
      RtcEngineContext context = RtcEngineContext(gAPPID);
      RtcEngine engine = await RtcEngine.createWithContext(context);

      engine.setEventHandler(
        RtcEngineEventHandler(
          joinChannelSuccess: (String channel, int uid, int elapsed) {
            print('joinChannelSuccess $channel} $uid}');
            streamController.add(CallStatus.WAITING);
          },
          userJoined: (int uid, int elapsed) {
            print('userJoined $uid}');
            streamController.add(CallStatus.CONNECTED);
          },
          userOffline: (int uid, UserOfflineReason reason) {
            print('userOffline $uid}');
            streamController.add(CallStatus.NOTCONNECTED);
          },
          connectionLost: () {
            //TODO: disconnect call
          },
        ),
      );
      // Join channel with channel name as 123
      await engine.joinChannel(gTOKENID, callID, null, 0);
    } catch (error) {
      streamController.addError(error);
      //TODO: discconnect call
      streamController.close();
    }

    return streamController.stream;
  }
}
