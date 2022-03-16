import 'dart:async';
import 'dart:convert';

import 'package:gmoney/api/web_service_client.dart';
import 'package:gmoney/models/bank_details_res.dart';
import 'package:gmoney/models/ifsc_res-model.dart';
import 'package:gmoney/models/mandate_url_res.dart';
import 'package:gmoney/util/utils.dart';

import '../api/bloc_provider.dart';

class BankDetailsBloc extends BlocBase {
  var ifscDataController = StreamController<IfscRes>.broadcast();
  var mandateUrlController = StreamController<String>.broadcast();
  var agreementUrlController = StreamController<String>.broadcast();

  StreamSink<IfscRes> get _ifscDataSink => ifscDataController.sink;

  StreamSink<String> get _urlSink => mandateUrlController.sink;
  StreamSink<String> get _urlAgreementSink => agreementUrlController.sink;

  //Add data to stream

  Stream<IfscRes> get ifscDataStream => ifscDataController.stream;

  Stream<String> get urlAgreementStream => agreementUrlController.stream;
  Stream<String> get urlDataStream => mandateUrlController.stream;

//Get IFSC details
  Future getIfscDetails(Map<String, dynamic> parameters, String ifsc) async {
    return WebServiceClient.getIfscService(parameters, ifsc)
        .then((response) async {
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
        print("json.decode(response)");

        var ifscDataRes =
            IfscRes.fromJson(json.decode(json.encoder.convert(response)));
        _ifscDataSink.add(ifscDataRes);
        return response;
      }
    }).catchError((e) {
      print(e);
      Utils.showErrorMessage("Error. Please try again");
    });
  }

  //Bank Details
  Future addBankDetails(Map<String, dynamic> parameters) async {
    return WebServiceClient.postBankDetails(parameters).then((response) async {
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
        BankDetailsRes bankRes = BankDetailsRes.fromJson(
            json.decode(json.encoder.convert(response)));
        // _addNewResSink.add(addNewRes);
        return bankRes;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again");
    });
  }

  //Mandate
  Future postMandateUrl(Map<String, dynamic> parameters) async {
    return WebServiceClient.postCustomerMandate(parameters)
        .then((response) async {
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
        print("json.decode(response)");

        MandateUrlRes res =
            MandateUrlRes.fromJson(json.decode(json.encoder.convert(response)));
        _urlSink.add(res.data!);
        return true;
      }
    }).catchError((e) {
      print(e);
      Utils.showErrorMessage("Error. Please try again");
    });
  }

  //Agreement
  Future postAgreementUrl(Map<String, dynamic> parameters) async {
    return WebServiceClient.postCustomerAgreement(parameters)
        .then((response) async {
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
        print("json.decode(response)");

        MandateUrlRes res =
        MandateUrlRes.fromJson(json.decode(json.encoder.convert(response)));
        _urlAgreementSink.add(res.data!);
        return true;
      }
    }).catchError((e) {
      print(e);
      Utils.showErrorMessage("Error. Please try again");
    });
  }

  @override
  void dispose() {
    ifscDataController.close();
    agreementUrlController.close();
    mandateUrlController.close();
  }
}

BankDetailsBloc bankDetailsBloc = BankDetailsBloc();
