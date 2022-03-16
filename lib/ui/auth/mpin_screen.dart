import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmoney/bloc/authentication_bloc.dart';
import 'package:gmoney/bloc/otp_bloc.dart';
import 'package:gmoney/ui/widgets/otp_code_field.dart';
import 'package:gmoney/util/utils.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewMPin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewMPinState();
  }
}

class NewMPinState extends State<NewMPin> with ScreenLoader {
  String? re_mPinController="" ;
  bool? isChecked = false;
  String? mPinController="" ;

// create/validate mpin
  createPin() async {

  await  otpBloc.mPinFieldTwoStream.listen((event) {
    re_mPinController=event;
  });
  print(mPinController);
  print(re_mPinController);
    if (mPinController!=null &&mPinController!.isEmpty || re_mPinController!=null &&re_mPinController!.isEmpty) {
      print("Please enter 4 digit MPin 1");
      print(mPinController);
      print(re_mPinController);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter 4 digit MPin")));
      Utils.instance.showToast("Please enter 4 digit MPin",isBottom: false);
      return;
    }
    if (mPinController!=null &&mPinController!.length < 4 ||re_mPinController!=null && re_mPinController!.length < 4) {
      Utils.instance.showToast("Please enter 4 digit MPin",isBottom: false);
      print("Please enter 4 digit MPin 2");

      return;
    }
    if (mPinController!=null &&re_mPinController!=null &&(mPinController != re_mPinController)) {
      Utils.instance.showToast("4 digit MPin do not match",isBottom: false);
      print("Please enter 4 digit MPin 4");

      return;
    }
    var data = {"mpin": re_mPinController, "device_login": true};
   // var prefs = await SharedPreferences.getInstance();
   /* if (isChecked!) {
     await prefs.setBool("fingerPrintEnabled", true);
    } else {
     await prefs.setBool("fingerPrintEnabled", false);
    }
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/PinAuthScreen', (Route<dynamic> route) => false);*/
    startLoading();
    authBloc.createMPin(data).then((value) async {
      var sp = await SharedPreferences.getInstance();
      sp.setString("mPin", mPinController??"");
      var prefs =await SharedPreferences.getInstance();
      if(isChecked!){
        prefs.setBool("fingerPrintEnabled", true);
      }else{
        prefs.setBool("fingerPrintEnabled", false);
      }
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/PinAuthScreen', (Route<dynamic> route) => false);

    });
    stopLoading();
  }

  @override
  Widget screen(BuildContext context) {
    // TODO: implement screen
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
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 15),
                        child: Text(
                          "Create mPIN",
                          style: TextStyle(
                              color: DefaultColor.blueDarkLogin,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: Text("Set your mPIN to login",
                            style: TextStyle(
                                color: DefaultColor.blackSubText,
                                fontSize: 16)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 15, bottom: 10),
                        child: Text(
                          "Enter 4 digit mPIN",
                          style: TextStyle(
                              color: DefaultColor.blackSubText, fontSize: 16),
                        ),
                      ),
                      StreamBuilder<String>(
                        stream: otpBloc.mPinFieldOneStream,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            mPinController=snapshot.data;
                          }
                          return OtpCodeField(length: 4,isFrom: "CreateMPinFieldOne",isEnabled: true);
                        }
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Text(
                          "Re-enter 4 digit mPIN",
                          style: TextStyle(
                              color: DefaultColor.blackSubText, fontSize: 16),
                        ),
                      ),
                      StreamBuilder<String>(
                        stream: otpBloc.mPinFieldTwoStream,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            re_mPinController=snapshot.data;
                          }
                          return OtpCodeField(length: 4,isFrom: "CreateMPinFieldTwo",isEnabled: true);
                        }
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CheckboxListTile(
                          title: Text(
                            "Enable fingerprint verification for easy login",
                            style: TextStyle(
                                color: DefaultColor.blackSubText, fontSize: 12),
                          ),
                         // visualDensity: VisualDensity.adaptivePlatformDensity,
                          contentPadding: EdgeInsets.zero,
                          value: isChecked,
                          onChanged: (newValue) {
                            setState(() {
                              isChecked = newValue;
                            });
                          },
                          activeColor: DefaultColor.blueDark,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: ElevatedButton(
                            onPressed: () async {
                              createPin();
//API hit to receive code
                            },
                            child: Text(
                              "Create",
                              style: TextStyle(color: DefaultColor.appBarWhite),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 0)),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  const Size(double.infinity, 50)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  DefaultColor.blueDark),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              )),
                            ),
                          ),
                        ),
                      )
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
