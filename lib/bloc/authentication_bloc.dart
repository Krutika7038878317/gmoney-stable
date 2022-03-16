import 'package:gmoney/api/bloc_provider.dart';
import 'package:gmoney/api/web_service_client.dart';
import 'package:gmoney/util/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

import 'otp_bloc.dart';


class AuthBloc extends BlocBase{

  var otp = BehaviorSubject<String>();
  Stream<String> get otpStream => otp.stream.asBroadcastStream();




  //hit send otp api and get data or webErrors
  Future sendOtp(Map<String, dynamic> parameters) async {
    return WebServiceClient.postSendOtp(parameters).then((response) async {
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
      } else {
        return true;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }

  Future sendForMPinOtp(Map<String, dynamic> parameters) async {
    return WebServiceClient.postSendOtp(parameters).then((response) async {
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
      } else {
        otpBloc.otpNotifier.add("sent");
        return true;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }
  Future sendForAgreementOtp(Map<String, dynamic> parameters) async {
    return WebServiceClient.postSendOtp(parameters).then((response) async {
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
      } else {
        otpBloc.otpAgreementNotifier.add("sent");
        return true;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }


  //hit addNewItems api and get data or webErrors
  Future createMPin(Map<String, dynamic> parameters) async {
    return WebServiceClient.createMPinService(parameters).then((response) async {
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
      } else {
        // AddNewRes addNewRes = AddNewRes.fromJson(json.decode(response));
        // _addNewResSink.add(addNewRes);
        return true;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }
  //hit addNewItems api and get data or webErrors
  Future sendAgreement(Map<String, dynamic> parameters) async {
    return WebServiceClient.sendAgreementService(parameters).then((response) async {
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
      } else {
        // AddNewRes addNewRes = AddNewRes.fromJson(json.decode(response));
        // _addNewResSink.add(addNewRes);
        return true;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }

  Future readOTP() async {
    print("readOTP");
    final intRegex = RegExp(r'\d+', multiLine: true);
    String _otp = "";
    print("sending empty");
    otp.sink.add("");
  /*  await SmsVerification.startListeningSms().then((message) async {
      var a = SmsVerification.getCode(message, intRegex);
      print("values");
      print(a);
      // otp = a;
      // otp.sink.add(a);
    }).onError((error, stackTrace) {
      print("error otp");
    });*/
    return otp;
  }
//Verify OTP
  Future verifyOtp(Map<String, dynamic> parameters) async {
    return WebServiceClient.postVerifyOtp(parameters).then((response) async {
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
      } else {
        // AddNewRes addNewRes = AddNewRes.fromJson(json.decode(response));
        // _addNewResSink.add(addNewRes);
        return true;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }

//Verify OTP
  Future updateDeviceInfo(Map<String, dynamic> parameters) async {
    return WebServiceClient.postUpdateDeviceInfo(parameters).then((response) async {
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
      } else {
        // AddNewRes addNewRes = AddNewRes.fromJson(json.decode(response));
        // _addNewResSink.add(addNewRes);
        return true;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }

  @override
  void dispose() {
    print("stop otp");
    // SmsVerification.stopListening();
    otp.close();

    // TODO: implement dispose
  }
}
AuthBloc authBloc=AuthBloc();