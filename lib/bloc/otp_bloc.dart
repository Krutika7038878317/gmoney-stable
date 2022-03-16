import 'dart:async';

import 'package:gmoney/api/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class OtpBloc extends BlocBase{
  var _loginOtpController=StreamController<String>.broadcast();
  var _mPinFieldOneController=StreamController<String>.broadcast();
  var _mPinFieldTwoController=StreamController<String>.broadcast();
  var _mPinAuthController=StreamController<String>.broadcast();
  var _agreementController=StreamController<String>.broadcast();
  var _aadhaarDetailsController=StreamController<String>.broadcast();
  var otpNotifier = BehaviorSubject<String>();
  var otpAgreementNotifier = BehaviorSubject<String>();


  //sinks
  StreamSink<String> get loginOtpSink => _loginOtpController.sink;
  StreamSink<String> get mPinFieldOneSink => _mPinFieldOneController.sink;
  StreamSink<String> get mPinFieldTwoSink => _mPinFieldTwoController.sink;
  StreamSink<String> get mPinAuthSink => _mPinAuthController.sink;
  StreamSink<String> get agreementSink => _agreementController.sink;
  StreamSink<String> get aadhaarDetailsSink => _aadhaarDetailsController.sink;

  //Streams
 Stream<String> get loginOtpStream =>_loginOtpController.stream;
 Stream<String> get mPinFieldOneStream =>_mPinFieldOneController.stream;
 Stream<String> get mPinFieldTwoStream =>_mPinFieldTwoController.stream;
 Stream<String> get mPinAuthStream =>_mPinAuthController.stream;
 Stream<String> get agreementStream =>_agreementController.stream;
 Stream<String> get aadhaarDetailsStream =>_aadhaarDetailsController.stream;
  Stream<String> get otpNotifierStream => otpNotifier.stream.asBroadcastStream();
  Stream<String> get otpAgreementNotifierStream => otpAgreementNotifier.stream.asBroadcastStream();



  @override
  void dispose() {
    _loginOtpController.close();
    _mPinFieldOneController.close();
    _mPinAuthController.close();
    _mPinFieldTwoController.close();
    _agreementController.close();
    _aadhaarDetailsController.close();
    otpNotifier.close();
    // TODO: implement dispose
  }

}
OtpBloc otpBloc=OtpBloc();