import 'dart:io';

import 'package:gmoney/api/web_service_client.dart';
import 'package:gmoney/util/utils.dart';

import '../api/bloc_provider.dart';

class SelfieUploadBloc extends BlocBase {
//Get IFSC details
  Future uploadSelfie(
      Map<String, dynamic> parameters, List<File> file) async {
    return WebServiceClient.hitImageProfile(parameters, file)
        .then((response) async {
          print("response bloc");
          print(response);
      if (response is WebError) {
        switch (response) {
          case WebError.INTERNAL_SERVER_ERROR:
            {
              Utils.instance.showToast(
                  "Unable to reach server. Please check connection.");
              break;
            }
          case WebError.ALREADY_EXIST:
            {
              Utils.instance.showToast(
                  "This email or phone number is already registered.");
              break;
            }
          case WebError.NOT_FOUND:
            {
              Utils.instance.showToast(
                  "This email or phone number is already registered.");
              break;
            }
          default:
            Utils.instance.showToast(
                "Something went unexpectedly wrong. Please try again later");
            break;
        }
        return false;
      } else {
        // AddNewRes addNewRes = AddNewRes.fromJson(json.decode(response));
        // _addNewResSink.add(addNewRes);
        return true;
      }
    }).catchError((e) {
      Utils.instance.showToast("Error. Please try again");
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
  }
}

SelfieUploadBloc selfieUploadBloc = SelfieUploadBloc();
