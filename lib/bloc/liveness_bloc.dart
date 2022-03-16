import 'dart:async';

import '../api/bloc_provider.dart';
import '../api/web_service_client.dart';
import '../models/liveness_face_model.dart';
import '../util/utils.dart';


class LiveNessBloc implements BlocBase {
  final _liveNessModelRes = StreamController<LivenessFaceModel>.broadcast();

  // StreamSink<LivenessFaceModel> get _liveNessModelResSink => _liveNessModelRes.sink;



  //Add data to stream
  Stream<LivenessFaceModel> get liveNessDataStream => _liveNessModelRes.stream;

  Future faceData(String image64) async {
    return WebServiceClient.getFaceCheckLiveNessAPIData(image64).then((response) async {
      if (response is WebError) {
        switch (response) {
          case WebError.INTERNAL_SERVER_ERROR:
            {
              Utils.showErrorMessage(
                  "Unable to reach server. Please check connection.");
              break;
            }
          case WebError.ALREADY_EXIST:
            {
              Utils.showErrorMessage(
                  "This email or phone number is already registered.");
              break;
            }
          case WebError.NOT_FOUND:
            {
              Utils.showErrorMessage(
                  "This email or phone number is already registered.");
              break;
            }
          default:
            Utils.showErrorMessage(
                "Something went unexpectedly wrong. Please try again later");
            break;
        }
        return false;
      }
      else {
        LivenessFaceModel livenessFaceModel = response as LivenessFaceModel;
        _liveNessModelRes.sink.add(livenessFaceModel);
        print(livenessFaceModel);
        return livenessFaceModel;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _liveNessModelRes.close();
  }
}

LiveNessBloc liveNessBloc = new LiveNessBloc();
