import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gmoney/ui/widgets/permissions_view.dart';
import 'package:gmoney/util/utils.dart';
import 'package:permission_handler/permission_handler.dart';

import '../util/user_data.dart';

class PermissionsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PermissionsState();
  }
}

class PermissionsState extends State<PermissionsScreen> {
  bool? isChecked = false;

  Future<void> _checkPermission() async {
    final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
    final isGpsOn = serviceStatus == ServiceStatus.enabled;
    if (!isGpsOn) {
      print('Turn on location services before requesting permission.');
      return;
    }

    Map<Permission, PermissionStatus> statuses = await [
      Permission.contacts,
      Permission.location,
      Permission.camera,
      Permission.sms,
    ].request();

    for (var element in statuses.values) {
      final status = element;
      if (status == PermissionStatus.denied) {
        await [
          Permission.contacts,
          Permission.location,
          Permission.camera,
          Permission.sms,
        ].request();
        break;
      }
      if (status == PermissionStatus.permanentlyDenied) {
        print('Take the user to the settings page.');
        await openAppSettings();
        break;
      }
      if (statuses[Permission.contacts] == PermissionStatus.granted &&
          statuses[Permission.location] == PermissionStatus.granted &&
          statuses[Permission.camera] == PermissionStatus.granted &&
          statuses[Permission.sms] == PermissionStatus.granted) {
        EasyLoading.show();
          await UserData.getUserData();
        EasyLoading.dismiss();
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/LoginScreen', (Route<dynamic> route) => false);
        break;
        print('Permission granted');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: DefaultColor.lightGrey,
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 3,
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
          ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  color: DefaultColor.appBarWhite,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    children: [
                      PermissionsView(
                        icon: Icons.phone,
                        title: "Contact",
                        subTitle:
                            "Data is collected to build your profile and reach out to your contacts in case you are unreachable",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 2,
                          thickness: 1,
                          color: DefaultColor.appDividerColour,
                        ),
                      ),
                      PermissionsView(
                        icon: Icons.location_on,
                        title: "Location",
                        subTitle:
                            "We need this permission to prevent frauds and to push location-specific offers and alerts",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 2,
                          thickness: 1,
                          color: DefaultColor.appDividerColour,
                        ),
                      ),
                      PermissionsView(
                        icon: Icons.camera_alt,
                        title: "Camera",
                        subTitle:
                            "We need permission to help you upload documents when required",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 2,
                          thickness: 1,
                          color: DefaultColor.appDividerColour,
                        ),
                      ),
                      PermissionsView(
                        icon: Icons.sms_rounded,
                        title: "SMS",
                        subTitle:
                            "Only financial transcation SMS are collected to build a user credit profile",
                      ),
                    ],
                  ),
                ),
              ),
              CheckboxListTile(
                title: Text.rich(
                  TextSpan(
                    text: 'I agree to ',
                    style: TextStyle(fontSize: 16, color: DefaultColor.blackTC),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Privacy Policy ',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          )),
                      TextSpan(
                          text: 'and ',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                          )),
                      TextSpan(
                          text: 'Declaration and Undertaking.',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          )),
                      // can add more TextSpans here...
                    ],
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                value: isChecked,
                onChanged: (newValue) {
                  setState(() {
                    isChecked = newValue;
                  });
                },
                activeColor: DefaultColor.blueDark,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (isChecked!) {
                      await _checkPermission();
                    }
                  },
                  child: Text(
                    "Allow permission",
                    style: TextStyle(
                        color: isChecked!
                            ? DefaultColor.appBarWhite
                            : DefaultColor.blackButtonText),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 15)),
                    backgroundColor: MaterialStateProperty.all<Color>(isChecked!
                        ? DefaultColor.blueDark
                        : DefaultColor.greyButtonColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    )),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
