import 'package:flutter/material.dart';
import 'package:gmoney/bloc/otp_bloc.dart';
import 'package:gmoney/util/utils.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/authentication_bloc.dart';
import '../../widgets/otp_code_field.dart';

class AgreementScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AgreementScreenState();
  }
}

class AgreementScreenState extends State<AgreementScreen> with ScreenLoader {
  bool? isChecked = false;
  bool gotoLogin = false;
  String phoneNo = '';

  String? otpController;

  final intRegex = RegExp(r'\d+', multiLine: true);

  String? otp;

  bool? isOtpSent = false;

  @override
  void initState() {
    super.initState();

    _getSignatureCode();
  }

  @override
  void dispose() {
    //SmsVerification.stopListening();
    super.dispose();
  }

  /// get signature code
  _getSignatureCode() async {
    var sp = await SharedPreferences.getInstance();
    phoneNo = sp.getString(phoneNo) ?? "";
  }

  /// listen sms
  startListeningSms() {
    startLoading();
    if (phoneNo == null || phoneNo.isEmpty) phoneNo = "9653793049";
    var data = {"mobile": phoneNo};
    authBloc.sendOtp(data).then((value) {
      authBloc.readOTP().then((value) {});
      stopLoading();
    });
  }

  @override
  Widget screen(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColor.lightGrey,
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: new BoxDecoration(
                  color: DefaultColor.lightGrey,
                  gradient: new LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      DefaultColor.blueDark,
                      DefaultColor.blueLightGradient
                    ],
                  ))),
          Column(
            children: [
              Expanded(
                flex: 6,
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: DefaultColor.appBarWhite,
                                )),
                            Text(
                              "Complete your KYC",
                              style: TextStyle(
                                  color: DefaultColor.appBarWhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
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
                              padding: const EdgeInsets.only(
                                  top: 20, left: 15, right: 15),
                              child: Text(
                                "Agreement",
                                style: TextStyle(
                                    color: DefaultColor.blueDarkLogin,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            // agreement text
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. \n Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \n \n" *
                                      7,
                                  style: TextStyle(
                                      color: DefaultColor.blackSubText,
                                      fontSize: 14)),
                            ),

                            // agreement check
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                              child: CheckboxListTile(
                                title: Text.rich(
                                  TextSpan(
                                    text: 'I agree to the agreement',
                                    style: TextStyle(
                                      fontSize:
                                          16, /*color: DefaultColor.blackTC*/
                                    ),
                                  ),
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 8),
                                value: isChecked,
                                onChanged: (newValue) {
                                  setState(() {
                                    isChecked = newValue;
                                  });
                                },
                                activeColor: DefaultColor.blueDark,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            ),

                            StreamBuilder<String>(
                                stream: otpBloc.otpAgreementNotifierStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData &&
                                      snapshot.data == "sent") {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                          child: Text(
                                              "Please enter the OTP sent on your registered mobile number",
                                              style: TextStyle(
                                                  color:
                                                      DefaultColor.blackSubText,
                                                  fontSize: 16)),
                                        ),
                                        StreamBuilder<String>(
                                            stream: otpBloc.agreementStream,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                otp = snapshot.data;
                                              }
                                              return OtpCodeField(
                                                  length: 4,
                                                  isFrom: "Agreement",
                                                  isEnabled: true);
                                            }),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                // createPin();
                                                if(!isChecked!) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Please click the checkbox above for agreement")));
                                                  Utils.instance.showToast(
                                                      "Please click the checkbox above for agreement",
                                                      isBottom: false);
                                                  return;
                                                }
                                                if(otp == null){
                                                  Utils.instance.showToast(
                                                      "Please enter 4 digit OTP",
                                                      isBottom: false);
                                                  print(
                                                      "Please enter 4 digit OTP");
                                                  return;
                                                }
                                                if (isOtpSent! &&
                                                    isChecked! &&
                                                    otp != null &&
                                                    otp!.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Please enter 4 digit OTP")));
                                                  Utils.instance.showToast(
                                                      "Please enter 4 digit OTP",
                                                      isBottom: false);
                                                  return;
                                                }
                                                if (isOtpSent! &&
                                                    isChecked! &&
                                                    otp != null &&
                                                    otp!.length < 4) {
                                                  Utils.instance.showToast(
                                                      "Please enter 4 digit OTP",
                                                      isBottom: false);
                                                  print(
                                                      "Please enter 4 digit OTP");

                                                  return;
                                                }
                                                var sp = await SharedPreferences
                                                    .getInstance();

                                                var otpData = {
                                                  "mobile": sp
                                                      .getString("userMobile")!,
                                                  "mobileotp": otp
                                                };
                                                startLoading();
                                                await authBloc
                                                    .verifyOtp(otpData)
                                                    .then((value) async {
                                                  await authBloc
                                                      .sendAgreement(Map())
                                                      .then((value) async {

                                                    Navigator.of(context)
                                                        .pushNamedAndRemoveUntil(
                                                            '/KycCompleteScreen',
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
                                                  });
                                                  stopLoading();
                                                });
                                                stopLoading();
                                              },
                                              child: Text(
                                                "Submit",
                                                style: TextStyle(
                                                    color: DefaultColor
                                                        .appBarWhite),
                                              ),
                                              style: ButtonStyle(
                                                padding: MaterialStateProperty
                                                    .all<EdgeInsets>(
                                                        EdgeInsets.symmetric(
                                                            vertical: 15,
                                                            horizontal: 0)),
                                                minimumSize:
                                                    MaterialStateProperty
                                                        .all<Size>(const Size(
                                                            double.infinity,
                                                            50)),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        DefaultColor.blueDark),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if(isChecked!){
                                              var sp = await SharedPreferences
                                                  .getInstance();
                                              var data = {
                                                "mobile":
                                                sp.getString("userMobile")!
                                              };
                                              startLoading();
                                              await authBloc
                                                  .sendForAgreementOtp(data)
                                                  .then((value) =>
                                              isOtpSent = true);
                                              stopLoading();
                                            }else{
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Please click the checkbox above for agreement")));
                                              Utils.instance.showToast(
                                                  "Please click the checkbox above for agreement",
                                                  isBottom: false);
                                            }

                                          },
                                          child: Text(
                                            "Send Otp",
                                            style: TextStyle(
                                                color:
                                                    DefaultColor.appBarWhite),
                                          ),
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsets>(
                                                EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 0)),
                                            minimumSize:
                                                MaterialStateProperty.all<Size>(
                                                    const Size(
                                                        double.infinity, 50)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
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
                                    );
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
