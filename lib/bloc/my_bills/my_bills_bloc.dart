import 'package:flutter/material.dart';
import 'package:gmoney/api/bloc_provider.dart';
import 'package:gmoney/models/cardsListModel.dart';
import 'package:gmoney/models/my_bills_model.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/web_service_client.dart';
import '../../util/utils.dart';





class MyBillsBloc implements BlocBase{
  List<CardsListModel> myCards = [
    CardsListModel(cardNumber: "3455 XXXX XXXX 2423", index: 0, cardImg: ""),
    CardsListModel(cardNumber: "7485 XXXX XXXX 5443", index: 1, cardImg: ""),
    CardsListModel(cardNumber: "8475 XXXX XXXX 9423", index: 2, cardImg: ""),
  ];
  List months =
  ['Jan', 'Feb', 'Mar', 'Apr', 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

  var _myBillsCont = BehaviorSubject<MyBillsModel>();
  Stream<MyBillsModel> get getMyBillsData => _myBillsCont.stream;
  Sink<MyBillsModel> get updateMyBillsData => _myBillsCont.sink;

  var _policyCheckBoxCont = BehaviorSubject<bool?>();
  Stream<bool?> get getPolicyCheckBox => _policyCheckBoxCont.stream;
  Sink<bool?> get updatePolicyCheckBox => _policyCheckBoxCont.sink;


  MyBillsBloc(){
    getBillsDataApi();
  }


  Future getBillsDataApi() async {
    return WebServiceClient.getBillsPresented({}).then((response) async {
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
        var _data = MyBillsModel.fromJson(response);
        updateMyBillsData.add(_data);
        return true;
      }
    }).catchError((e) {
      Utils.showErrorMessage("Error. Please try again $e");
    });
  }

  Future updateBillsStatus() async {
    return WebServiceClient.submitOffer({}).then((response) async {
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
      Utils.showErrorMessage("Error. Please try again $e");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}
MyBillsBloc myBillsBloc = MyBillsBloc();