import 'dart:io';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gmoney/bloc/authentication_bloc.dart';
import 'package:gmoney/bloc/otp_bloc.dart';
import 'package:gmoney/ui/widgets/otp_code_field.dart';
import 'package:gmoney/util/constant/constants.dart';
import 'package:gmoney/util/utils.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/location_data.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class PinAuth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PinAuthState();
  }
}

class PinAuthState extends State<PinAuth> {
  String? mPinController="" ;
  late SharedPreferences prefs;
  bool? isEnabled = false;
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  String fcm_token = "";

  String? id;

  String? model;
  String? version_id;

  String? ip;

  String? versionName;

  String? name;

  String? notification_id;

  String? lat;

  String? lng;

  @override
  void initState() {
    // TODO: implement initState
    getPrefs();
    getPermissionData();
    super.initState();
  }

  Future getToken() async {
    prefs = await SharedPreferences.getInstance();
    var _sToken = prefs.getString(PREF_TOKEN);
    if (prefs.containsKey('FCM_TOKEN') &&
        prefs.getString('FCM_TOKEN') != null &&
        prefs.getString('FCM_TOKEN') != "null")
      fcm_token = prefs.getString("FCM_TOKEN")!;
    return _sToken;
  }

  Future<void> initPlatformState() async {
    if (Platform.isIOS) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.nodename}');
      id = iosInfo.identifierForVendor;
      model = iosInfo.utsname.machine;
      version_id = iosInfo.utsname.version;
    } else if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');
      id = androidInfo.androidId;
      model = androidInfo.model;
      version_id = androidInfo.id;
    }
    // e.g. "Moto G (4)"

    if (!mounted) return;
  }

  Future<void> getIpAddress() async {
    final ipv4 = await Ipify.ipv4();
    ip = ipv4;
    print(ipv4);
  }

  void getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    name = appName;

    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    versionName = version;
    String buildNumber = packageInfo.buildNumber;
  }

  // void getNotiID() async {
  //   await FirebaseMessaging.instance.getToken().then((value) {
  //     notification_id = value;
  //   });
  //   print(notification_id ?? "");
  //   debugPrint("notification_id: " + '$notification_id');
  // }

  void getPostion() async {
    Map<Permission, PermissionStatus>? locationPermissionStatus;
    if (locationPermissionStatus?[Permission.locationWhenInUse]?.isDenied ??
        false ||
            locationPermissionStatus?[Permission.locationWhenInUse]?.isDenied ==
                null) {
      print('Location Permission Denied');
    } else {
      Position position = await LocationData
          .getGeoLocationPosition(); //_getGeoLocationPosition();
      lat = position.latitude.toString();
      lng = position.longitude.toString();
      //GetAddressFromLatLong(position);
      var add = LocationData.GetAddressFromLatLong(position);
      print(add);
    }
  }

  Map<String, dynamic> _readAndroidBuildData() {
    return <String, dynamic>{
      "id": id,
      "model": model,
      "version_id": version_id,
      "version": versionName,
      "name": name,
      "notification_id": fcm_token,
      "ip": ip,
      "lat": lat ?? "79.000658",
      "lng": lng ?? "79.789456",
    };
  }

  void getPermissionData() async {
    await getToken();
    getPackageInfo();
    getPostion();
    await getIpAddress();
    await initPlatformState();
//    getNotiID();
  }

  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isEnabled = prefs.containsKey("fingerPrintEnabled")?prefs.getBool("fingerPrintEnabled"):false;
    });
    if (isEnabled!) {
      auth.isDeviceSupported().then(
            (bool isSupported) => setState(() => _supportState = isSupported
                ? _SupportState.supported
                : _SupportState.unsupported),
          );
    }
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }


  Future<void> _authenticate() async {
    bool authenticated = false;
    const iosStrings = const IOSAuthMessages(
        cancelButton: 'cancel',
        goToSettingsButton: 'settings',
        goToSettingsDescription: 'Please set up your Touch ID.',
        lockOut: 'Please re-enable your Touch ID');
    const androidStrings = const AndroidAuthMessages(
      cancelButton: 'cancel',
      goToSettingsButton: 'settings',
      goToSettingsDescription: 'Please set up your Touch ID.',
      signInTitle: "Gmoney Authentication",
    );
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason: 'Gmoney wants to authenticate',
          useErrorDialogs: true,
          iOSAuthStrings: iosStrings,
          androidAuthStrings: androidStrings,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
      if (authenticated){
         authBloc.updateDeviceInfo(_readAndroidBuildData());
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/HomeScreen', (Route<dynamic> route) => false);
      }


    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    auth.stopAuthentication();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                          "Enter mPIN",
                          style: TextStyle(
                              color: DefaultColor.blueDarkLogin,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        child: Text("Enter your mPIN to login",
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
                      OtpCodeField(length: 4,isFrom: "MPinField",isEnabled: true),
                      StreamBuilder<String>(
                        stream: otpBloc.mPinAuthStream,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            mPinController=snapshot.data;
                          }
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  SharedPreferences prefs;
                                  prefs = await SharedPreferences.getInstance();
                                  String mPin = "";
                                  if(prefs.containsKey('mPin') && prefs.getString('mPin') !=null && prefs.getString('mPin') != "null" )
                                    mPin = prefs.getString('mPin')!;

                                  if (mPin.toString() == mPinController &&
                                      mPinController!.length == 4) {

                                   await authBloc.updateDeviceInfo(_readAndroidBuildData());
                                    Navigator.of(context).pushNamedAndRemoveUntil(
                                         '/HomeScreen',
                                         (Route<dynamic> route) => false);
                                  } else {

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Please enter valid MPin")));
                                  }
                                },
                                child: Text(
                                  "Login",
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
                          );
                        }
                      ),
                      Offstage(
                        offstage: isEnabled! ? false : true,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 20, left: 20, right: 15),
                          child: Text(
                            "OR",
                            style: TextStyle(
                                color: DefaultColor.blueDarkLogin,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: isEnabled! ? false : true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Text(
                            isEnabled!
                                ? "Click here for biometric authentication"
                                : "Please enable biometric authentication",
                            style: TextStyle(
                                color: DefaultColor.blackSubText, fontSize: 16),
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: isEnabled! ? false : true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_supportState == _SupportState.supported)
                                _authenticate();
                            },
                            child: Icon(
                              Icons.fingerprint_rounded,
                              size: 30,
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
