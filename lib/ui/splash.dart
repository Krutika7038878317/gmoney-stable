import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gmoney/bloc/authentication_bloc.dart';
import 'package:gmoney/data/location_data.dart';
import 'package:gmoney/util/constant/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_ipify/dart_ipify.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late SharedPreferences prefs;
  String mPin = "";
  Future getToken() async {
    prefs = await SharedPreferences.getInstance();
    var _sToken = prefs.getString(PREF_TOKEN);
    if (prefs.containsKey('mPin') &&
        prefs.getString('mPin') != null &&
        prefs.getString('mPin') != "null") mPin = prefs.getString('mPin')!;
    return _sToken;
  }

  @override
  void initState() {
    super.initState();
    //getPermissionData();
    Timer(
        Duration(seconds: 3),
        () => {
              getToken().then((token) {
                print('token');
                print(token);
                print(mPin);


                if ((token == null || token.toString().isEmpty) &&
                    mPin.length <= 0)
                  Navigator.of(context)
                      .pushReplacementNamed('/TutorialScreens');
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     '/TutorialScreens', (Route<dynamic> route) => false);
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //       '/CreateMPinScreen', (Route<dynamic> route) => false);

                else if ((token != null || token.toString().isNotEmpty) &&
                    mPin.length <= 0) {
                  /// enter m pin screen
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/CreateMPinScreen', (Route<dynamic> route) => false);
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/PinAuthScreen',
                      //'/CreateMPinScreen',
                      // '/HomeScreen',
                      (Route<dynamic> route) => false);
                }
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: <Widget>[
        Image.asset(
          'assets/images/Rectangle 4272.png',
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Image.asset(
          'assets/images/Logo.png',
        ),
      ],
    )
            );
  }
}
/*ListView.builder(itemBuilder: (context, index) {
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 20),
child: TimelineTile(
axis: TimelineAxis.vertical,
afterLineStyle: LineStyle(color: DefaultColor.blueDark),
beforeLineStyle: LineStyle(color: DefaultColor.blueLightGradient),
isFirst:index==0?true:false,
isLast: index==4?true:false,
hasIndicator: true,
lineXY: 50,
endChild: Text("vfjnvfnv"),
alignment: TimelineAlign.center,
indicatorStyle: IndicatorStyle(
drawGap: false,

)),
);
},itemCount: 5),*/
/*ListView.builder(itemBuilder: (context, index) {
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 20),
child: TimelineTile(
axis: TimelineAxis.vertical,
afterLineStyle: LineStyle(color: DefaultColor.blueDark),
beforeLineStyle: LineStyle(color: DefaultColor.blueLightGradient),
isFirst:index==0?true:false,
isLast: index==4?true:false,
hasIndicator: true,
lineXY: 50,
endChild: Text("vfjnvfnv"),
alignment: TimelineAlign.center,
indicatorStyle: IndicatorStyle(
drawGap: false,

)),
);
},itemCount: 5),*/
