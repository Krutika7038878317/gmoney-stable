import 'dart:io';

import 'package:gmoney/api/bloc_provider.dart';
import 'package:gmoney/api/web_service_client.dart';
import 'package:gmoney/util/utils.dart';
import 'package:rxdart/rxdart.dart';

import '../models/aadhar_upload_model.dart';

class AadhaarBloc extends BlocBase{

  var otp = BehaviorSubject<String>();
  Stream<String> get otpStream => otp.stream.asBroadcastStream();

  var _aadhaarUploadDataCont = BehaviorSubject<AAdharUploadModel>();
  Stream<AAdharUploadModel> get aadhaarUploadData => _aadhaarUploadDataCont.stream;
  Sink<AAdharUploadModel> get updateaAdhaarUploadData => _aadhaarUploadDataCont.sink;

  //hit send otp api and get data or webErrors
  Future sendOtp(Map<String, dynamic> parameters) async {
    return WebServiceClient.aadhaarGenerateOtp(parameters).then((response) async {
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
            case WebError.BAD_REQUEST:
            {
              Utils.showErrorMessage(
                  "This email or phone number is already registered.");
              break;
            }
          default:
            try{
              Utils.showErrorMessage(
                  response.toString());
            }catch(e){
              print(e);
            }
            Utils.showErrorMessage(
                "Something went unexpectedly wrong. Please try again later");
            break;
        }
        return false;
      }
      else {
        Utils.showErrorMessage(
            "OTP successfully generated");
        // AddNewRes addNewRes = AddNewRes.fromJson(json.decode(response));
        // _addNewResSink.add(addNewRes);
        return true;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }

//Verify OTP
  Future verifyOtp(Map<String, dynamic> parameters) async {
    return WebServiceClient.aadhaarVerifyOtp(parameters).then((response) async {
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

// Upload aadhar
  Future fetchAadhaarUploadData(
      Map<String, dynamic> parameters, List<File> file, [Map<String, File>? fileMap]) async {
    return WebServiceClient.fetchAadhaarUploadData(parameters, file, fileMap)
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
    print("stop otp");
    // SmsVerification.stopListening();
    otp.close();
    _aadhaarUploadDataCont.close();
    // TODO: implement dispose
  }
}
AadhaarBloc aadhaarBloc=AadhaarBloc();