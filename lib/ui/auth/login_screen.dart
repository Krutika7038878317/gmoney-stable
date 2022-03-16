import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gmoney/bloc/authentication_bloc.dart';
import 'package:gmoney/bloc/otp_bloc.dart';
import 'package:gmoney/ui/widgets/otp_code_field.dart';
import 'package:gmoney/util/utils.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/constant/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }

}
class LoginState extends State<LoginScreen> with ScreenLoader{
  var textController = TextEditingController();

  final intRegex = RegExp(r'\d+', multiLine: true);
  var prefs;
  String mPin = "";
  String? token = "";
  bool gotoLogin = false;

  Future getToken() async {
    prefs = await SharedPreferences.getInstance();
    token =
    prefs.containsKey(PREF_TOKEN) ?await  prefs.getString(PREF_TOKEN) ?? "" : "";
    print("token at login screen ${prefs.getString(PREF_TOKEN)}");
    mPin = prefs.containsKey("mPin") ? await prefs.getString('mPin') ?? "" : "";
  }

  /// get signature code
  _getSignatureCode() async {
    //String? signature = await SmsVerification.getAppSignature();
    // print("signature $signature");
  }

  /// listen sms
  _startListeningSms() {
    var data = {"mobile": textController.text};
startLoading();
    authBloc.sendOtp(data).then((value) {
      authBloc.readOTP().then((value) {
        // _otpCode = value;
        // otpController.text = authBloc.otp;
        // _onOtpCallBack(value, true);
      });
    });
    stopLoading();
  }

  @override
  void initState() {
    // TODO: implement initState
    getToken();
    _getSignatureCode();
    super.initState();
  }


  @override
  Widget screen(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: new BoxDecoration(
                  color: DefaultColor.lightGrey,
                  gradient: new LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [DefaultColor.blueDark, DefaultColor.blueLightGradient],
                  ))),
          ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 7,
                width: MediaQuery.of(context).size.width / 7,
                child: Image.asset("assets/images/Logo.png"),
                margin: EdgeInsets.symmetric(vertical: 10),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  color: DefaultColor.appBarWhite,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: DefaultColor.blueDarkLogin,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 15),
                        child: Text("Please enter your mobile number",
                            style: TextStyle(
                                color: DefaultColor.blackSubText,
                                fontSize: 16)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 11,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 6),
                              child: Text(
                                "Mobile Number",
                                style:
                                TextStyle(color: DefaultColor.blueMobile),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 6),
                              child: TextField(
                                  controller: textController,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  style: TextStyle(fontSize: 20),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    isDense: true,
                                    border: InputBorder.none,
                                  )),
                            ),
                          ],
                        ),
                        margin:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            border: Border.all(color: DefaultColor.blueMobile),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                      ),
                      StreamBuilder<String>(
                          stream: otpBloc.loginOtpStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text(
                                      "Please enter the OTP sent on your registered mobile number",
                                      style: TextStyle(
                                          color: DefaultColor.blackSubText,
                                          fontSize: 16),
                                    ),
                                  ),
                                  OtpCodeField(
                                      isEnabled: true,
                                      isFrom: "Login",
                                      length: 4),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (textController.text.length > 9 &&
                                              snapshot.data != null &&
                                              snapshot.data!.length > 3) {
                                            startLoading();
                                            authBloc.verifyOtp({
                                              "mobile": textController.text,
                                              "mobileotp": snapshot.data
                                            }).then((value) {
                                              if (value) {
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                    '/CreateMPinScreen',
                                                        (Route<dynamic>
                                                    route) =>
                                                    false);
                                                stopLoading();
                                                // String mPin = "";
                                                // if (prefs.containsKey('mPin') &&
                                                //     prefs.getString('mPin') !=
                                                //         null &&
                                                //     prefs.getString('mPin') !=
                                                //         "null" /*&& prefs.getString('mPin') != ""*/)
                                                //   mPin =
                                                //   prefs.getString('mPin')!;
                                                // token=prefs.getString(PREF_TOKEN)! ;
                                                // print("mPin is ${token} ${mPin.length} ${mPin}");
                                                // if (token!.isNotEmpty &&
                                                //     mPin.length == 0) {
                                                //   /// enter m pin screen
                                                //   Navigator.of(context)
                                                //       .pushNamedAndRemoveUntil(
                                                //       '/CreateMPinScreen',
                                                //           (Route<dynamic>
                                                //       route) =>
                                                //       false);
                                                // } else
                                                //   Navigator.of(context)
                                                //       .pushNamedAndRemoveUntil(
                                                //     // '/TakePictureScreen', (Route<dynamic> route) => false);
                                                //     // '/CreateMPinScreen', (Route<dynamic> route) => false);
                                                //       '/PinAuthScreen',
                                                //           (Route<dynamic>
                                                //       route) =>
                                                //       false);
                                                // ;
                                              }
                                            });
                                            stopLoading();
                                          } else if (textController
                                              .text.length <
                                              10) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please enter valid phone number")));
                                            stopLoading();
                                          }

                                          // Navigator.of(context).pushNamedAndRemoveUntil(
                                          //     '/CreateMPinScreen', (Route<dynamic> route) => false);
                                        },
                                        child: StreamBuilder<String>(
                                            stream: authBloc.otp,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                gotoLogin = true;
                                                return Text(
                                                  "Login",
                                                  style: TextStyle(
                                                      color: DefaultColor
                                                          .appBarWhite),
                                                );
                                              } else {
                                                return Text(
                                                  "Send Otp",
                                                  style: TextStyle(
                                                      color: DefaultColor
                                                          .appBarWhite),
                                                );
                                              }
                                            }),
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 0)),
                                          minimumSize:
                                          MaterialStateProperty.all<Size>(
                                              const Size(
                                                  double.infinity, 50)),
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              DefaultColor.blueDark),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Column(
                              children: [
                                StreamBuilder<String>(

                                    stream: authBloc.otp,
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        gotoLogin=true;
                                      }
                                      return Offstage(
                                        offstage: gotoLogin == false ? true : false,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          child: Text(
                                            "Please enter the OTP sent on your registered mobile number",
                                            style: TextStyle(
                                                color: DefaultColor.blackSubText,
                                                fontSize: 16),
                                          ),
                                        ),
                                      );
                                    }
                                ),
                                StreamBuilder<String>(
                                    stream: authBloc.otp,
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        gotoLogin=true;
                                      }
                                      return Offstage(
                                          offstage: gotoLogin == false ? true : false,
                                          child: OtpCodeField(
                                              isEnabled: true,
                                              isFrom: "Login",
                                              length: 4));
                                    }
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (!gotoLogin &&
                                            textController.text.length > 9) {
                                          _startListeningSms();
                                        }
                                        // if (!gotoLogin &&
                                        //     textController.text.length > 9) {
                                        //   _startListeningSms();
                                        // } else {
                                        //   if (textController.text.length > 9 &&
                                        //       otpController.text.length > 3) {
                                        //     authBloc.verifyOtp({
                                        //       "mobile": textController.text,
                                        //       "mobileotp": otpController.text
                                        //     }).then((value) {
                                        //       if (value) {
                                        //         String mPin = "";
                                        //         if (prefs.containsKey('mPin') &&
                                        //             prefs.getString('mPin') != null &&
                                        //             prefs.getString('mPin') != "null"/*&& prefs.getString('mPin') != ""*/)
                                        //           mPin = prefs.getString('mPin')!;
                                        //         print("mPin is $mPin");
                                        //         if (token.isNotEmpty &&
                                        //             mPin.length <= 0) {
                                        //           /// enter m pin screen
                                        //           Navigator.of(context)
                                        //               .pushNamedAndRemoveUntil(
                                        //               '/CreateMPinScreen',
                                        //                   (Route<dynamic> route) =>
                                        //               false);
                                        //         } else
                                        //           Navigator.of(context).pushNamedAndRemoveUntil(
                                        //             // '/TakePictureScreen', (Route<dynamic> route) => false);
                                        //             // '/CreateMPinScreen', (Route<dynamic> route) => false);
                                        //               '/PinAuthScreen',
                                        //                   (Route<dynamic> route) => false);
                                        //         ;
                                        //       }
                                        //     });
                                        //   }
                                        //   else if (textController.text.length <10){
                                        //     ScaffoldMessenger.of(context).showSnackBar(
                                        //         SnackBar(
                                        //             content: Text(
                                        //                 "Please enter valid phone number")));
                                        //   }
                                        // }

                                        // Navigator.of(context).pushNamedAndRemoveUntil(
                                        //     '/CreateMPinScreen', (Route<dynamic> route) => false);
                                      },
                                      child: StreamBuilder<String>(
                                          stream: authBloc.otp,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              gotoLogin = true;
                                              return Text(
                                                "Login",
                                                style: TextStyle(
                                                    color: DefaultColor
                                                        .appBarWhite),
                                              );
                                            } else {
                                              return Text(
                                                "Send Otp",
                                                style: TextStyle(
                                                    color: DefaultColor
                                                        .appBarWhite),
                                              );
                                            }
                                          }),
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                            EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 0)),
                                        minimumSize: MaterialStateProperty.all<
                                            Size>(
                                            const Size(double.infinity, 50)),
                                        backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            DefaultColor.blueDark),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}