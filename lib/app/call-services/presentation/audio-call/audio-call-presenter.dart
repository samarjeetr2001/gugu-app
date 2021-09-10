import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:gugu/app/call-services/domain/entity/call-entity.dart';
import 'package:gugu/app/call-services/domain/usecase/end-call-usecase.dart';
import 'package:gugu/app/call-services/domain/usecase/make-call-usecase.dart';
import 'package:gugu/core/presentation/observer.dart';

class AudioCallPresenter extends Presenter {
  final MakeCallUsecase _makeCallUsecase;
  final EndCallUsecase _endCallUsecase;
  AudioCallPresenter(this._makeCallUsecase, this._endCallUsecase);

  @override
  dispose() {
    _makeCallUsecase.dispose();
    _endCallUsecase.dispose();
  }

  void makeCall(
      {required UseCaseObserver observer, required CallEntity callData}) {
    _makeCallUsecase.execute(observer, callData);
  }

  void endCall({required UseCaseObserver observer, required String userID}) {
    _endCallUsecase.execute(observer, userID);
  }
}
