import 'package:flutter/material.dart';
import 'package:gmoney/bloc/authentication_bloc.dart';
import 'package:gmoney/bloc/otp_bloc.dart';
import 'package:gmoney/ui/widgets/otp_code_field.dart';
import 'package:gmoney/util/utils.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeMPin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChangeMPinState();
  }
}

class ChangeMPinState extends State<ChangeMPin> with ScreenLoader {
  String? re_mPinController = "";

  String? otp = "";

  bool? isChecked = false;
  String? mPinController = "";

  String? currentMPin = "";

// create/validate mpin
  createPin() async {

    if (currentMPin != null && currentMPin!.isEmpty ) {
      print("Please enter 4 digit MPin current $currentMPin");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter 4 digit current MPin")));
      Utils.instance.showToast("Please enter 4 digit current MPin", isBottom: false);
      return;
    }
    if (currentMPin != null && currentMPin!.length < 4 ) {
      Utils.instance.showToast("Please enter 4 digit current MPin", isBottom: false);
      print("Please enter 4 digit MPin 2");

      return;
    }
    if (mPinController != null && mPinController!.isEmpty ||
        re_mPinController != null && re_mPinController!.isEmpty) {
      print("Please enter 4 digit MPin 1");
      print(mPinController);
      print(re_mPinController);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter 4 digit MPin")));
      Utils.instance.showToast("Please enter 4 digit MPin", isBottom: false);
      return;
    }
    if (mPinController != null && mPinController!.length < 4 ||
        re_mPinController != null && re_mPinController!.length < 4) {
      Utils.instance.showToast("Please enter 4 digit MPin", isBottom: false);
      print("Please enter 4 digit MPin 2");

      return;
    }
    if (mPinController != null &&
        re_mPinController != null &&
        (mPinController != re_mPinController)) {
      Utils.instance.showToast("4 digit MPin do not match", isBottom: false);
      print("Please enter 4 digit MPin 4");

      return;
    }
    if (mPinController != null &&
        re_mPinController != null &&
        (currentMPin == re_mPinController)) {
      Utils.instance.showToast("Please try different new 4 digit MPin then current MPin", isBottom: false);
      print("Please enter 4 digit MPin 4");

      return;
    }

    if (isChecked!&&otp != null && otp!.isEmpty ) {
      print("Please enter 4 digit MPin current $currentMPin");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter 4 digit otp")));
      Utils.instance.showToast("Please enter 4 digit otp", isBottom: false);
      return;
    }
    if (isChecked!&&otp != null && otp!.length < 4 ) {
      Utils.instance.showToast("Please enter 4 digit current MPin", isBottom: false);
      print("Please enter 4 digit MPin 2");

      return;
    }
    var sp =
    await SharedPreferences.getInstance();

    var otpData = {
      "mobile": sp.getString("userMobile")!,
      "mobileotp": otp
    };
    startLoading();
  await  authBloc.verifyOtp(otpData).then((value) async {

      var data = {"mpin": re_mPinController, "device_login": true};
     await authBloc.createMPin(data).then((value) async {
       sp.setString("mPin", re_mPinController??"");
       otpBloc.otpNotifier.add("");
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/PinAuthScreen', (Route<dynamic> route) => false);
      });
    });
    stopLoading();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget screen(BuildContext context) {
    // TODO: implement screen
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: new BoxDecoration(
                  color: DefaultColor.lightGrey,
                  gradient: new LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [DefaultColor.blueDark, DefaultColor.blueLightGradient],
                  ))),
          ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
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
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 15),
                        child: Text(
                          "Change mPIN",
                          style: TextStyle(
                              color: DefaultColor.blueDarkLogin,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 15, bottom: 10),
                        child: Text(
                          "Enter current mPIN",
                          style: TextStyle(
                              color: DefaultColor.blackSubText, fontSize: 16),
                        ),
                      ),
                      StreamBuilder<String>(
                          stream: otpBloc.mPinAuthStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              currentMPin = snapshot.data;
                            }
                            return OtpCodeField(
                                length: 4,
                                isFrom: "MPinField",
                                isEnabled: true);
                          }),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 15, bottom: 10),
                        child: Text(
                          "Enter new mPIN",
                          style: TextStyle(
                              color: DefaultColor.blackSubText, fontSize: 16,fontFamily: "Roboto"),
                        ),
                      ),
                      StreamBuilder<String>(
                          stream: otpBloc.mPinFieldOneStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              mPinController = snapshot.data;
                            }
                            return OtpCodeField(
                                length: 4,
                                isFrom: "CreateMPinFieldOne",
                                isEnabled: true);
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Text(
                          "Re-enter new mPIN",
                          style: TextStyle(
                              color: DefaultColor.blackSubText, fontSize: 16),
                        ),
                      ),
                      StreamBuilder<String>(
                          stream: otpBloc.mPinFieldTwoStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              re_mPinController = snapshot.data;
                            }
                            return OtpCodeField(
                                length: 4,
                                isFrom: "CreateMPinFieldTwo",
                                isEnabled: true);
                          }),

                      StreamBuilder<String>(
                          stream: otpBloc.otpNotifierStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data == "sent") {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Text(
                                      "Enter otp we sent on your mobile no.",
                                      style: TextStyle(
                                          color: DefaultColor.blackSubText, fontSize: 16),
                                    ),
                                  ),
                                  StreamBuilder<String>(
                                      stream: otpBloc.loginOtpStream,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          otp = snapshot.data;
                                        }
                                        return OtpCodeField(
                                            length: 4, isFrom: "Login", isEnabled: true);
                                      }),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          createPin();
                                        },
                                        child: Text(
                                          "Change Pin",
                                          style: TextStyle(
                                              color: DefaultColor.appBarWhite),
                                        ),
                                        style: ButtonStyle(
                                          padding:
                                              MaterialStateProperty.all<EdgeInsets>(
                                                  EdgeInsets.symmetric(
                                                      vertical: 15, horizontal: 0)),
                                          minimumSize:
                                              MaterialStateProperty.all<Size>(
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
                            } else {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      var sp =
                                      await SharedPreferences.getInstance();
                                      if (currentMPin != null && currentMPin!.isEmpty ) {
                                        print("Please enter 4 digit MPin current $currentMPin");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(content: Text("Please enter 4 digit current MPin")));
                                        Utils.instance.showToast("Please enter 4 digit current MPin", isBottom: false);
                                        return;
                                      }
                                      if (currentMPin != null && currentMPin!=sp.getString("mPin")! ) {
                                        print("Please enter 4 digit MPin current $currentMPin");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(content: Text("Please enter correct 4 digit current MPin")));
                                        Utils.instance.showToast("Please enter correct 4 digit current MPin", isBottom: false);
                                        return;
                                      }
                                      if (currentMPin != null && currentMPin!.length < 4 ) {
                                        Utils.instance.showToast("Please enter 4 digit current MPin", isBottom: false);
                                        print("Please enter 4 digit MPin 2");

                                        return;
                                      }
                                      if (mPinController != null && mPinController!.isEmpty ||
                                          re_mPinController != null && re_mPinController!.isEmpty) {
                                        print("Please enter 4 digit MPin 1");
                                        print(mPinController);
                                        print(re_mPinController);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(content: Text("Please enter 4 digit MPin")));
                                        Utils.instance.showToast("Please enter 4 digit MPin", isBottom: false);
                                        return;
                                      }
                                      if (mPinController != null && mPinController!.length < 4 ||
                                          re_mPinController != null && re_mPinController!.length < 4) {
                                        Utils.instance.showToast("Please enter 4 digit MPin", isBottom: false);
                                        print("Please enter 4 digit MPin 2");

                                        return;
                                      }
                                      if (mPinController != null &&
                                          re_mPinController != null &&
                                          (mPinController != re_mPinController)) {
                                        Utils.instance.showToast("4 digit MPin do not match", isBottom: false);
                                        print("Please enter 4 digit MPin 4");

                                        return;
                                      }
                                      if (mPinController != null &&
                                          re_mPinController != null &&
                                          (currentMPin == re_mPinController)) {
                                        Utils.instance.showToast("Please try different new 4 digit MPin then current MPin", isBottom: false);
                                        print("Please enter 4 digit MPin 4");

                                        return;
                                      }


                                      var data = {
                                        "mobile": sp.getString("userMobile")!
                                      };
                                      startLoading();
                                     await authBloc.sendForMPinOtp(data).then((value) => isChecked=true);
                                      stopLoading();
                                    },
                                    child: Text(
                                      "Send Otp",
                                      style: TextStyle(
                                          color: DefaultColor.appBarWhite),
                                    ),
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 0)),
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
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
                              );
                            }
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
