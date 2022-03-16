import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:gmoney/ui/splash.dart';
import 'package:gmoney/util/routes.dart';
import 'package:gmoney/util/utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


const String homeRoute = '/Splash';
List<CameraDescription> cameras = <CameraDescription>[];
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    flutterLocalNotificationsPlugin;

Future<void> _backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  final firstCamera = cameras.first;

  try {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    var sp=await SharedPreferences.getInstance();
    print("FCM ");
    await Firebase.initializeApp();
    await FirebaseMessaging.instance.getToken().then((value) {
      if(value!=null)
      sp.setString("FCM_TOKEN", value);
      print("FCM ${value}");
    });
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    late int _totalNotifications;
    _totalNotifications = 0;
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      final routeFromMessage = message?.data["route"];
      print(routeFromMessage ?? "");
    });

//     await FirebaseMessaging.instance.getToken().then((value) {
//       if(value!=null)
//       sp.setString("FCM_TOKEN", value);
//     });
//     //forground notification
//     FirebaseMessaging.onMessage.listen((message) {
//       // if (message.data != null) {
//
//       final routeMessage = message.data["route"];
//       if (routeMessage == "mandate_true") {
//         Future.delayed(Duration.zero, () async {
//           /*Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => MandateResponseScreen(
//                     status: "true",
//                   )));*/
//           //Navigator.of(context).pushNamed(AppPages.MANDATERESPONSESCREEN,
//           //  arguments: {"status": "true"});
//           // Get.toNamed(AppPages.MANDATERESPONSESCREEN,
//           //     arguments: {"status": "true"});
//           //Get.toNamed(AppPages.SELFIESCREEN, arguments: {"status": "true"});
//         });
//       } else if (routeMessage == "mandate_false") {
//         Future.delayed(Duration.zero, () async {
//           /* Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => MandateResponseScreen(
//                     status: "false",
//                   )));*/
//           /*Navigator.push(
//             context,
//             new MaterialPageRoute(
//                 builder: (context) => new MandateResponseScreen()),
//           );*/
//           //Get.toNamed(AppPages.TRANSACTION);
//           // Get.toNamed(AppPages.SELFIESCREEN, arguments: {"status": "false"});
//         });
//       }
//       // }
//     });
//
//     // when tap to notification open particluler screen in app is running in background
//     FirebaseMessaging.onMessageOpenedApp.listen((message) async {
//       final routeMessage = message.data["route"];
//
// /*
//       if (routeMessage == "mandate_true") {
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => MandateResponseScreen(
//                   status: "true",
//                 )));
//       } else if (routeMessage == "mandate_false") {
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => MandateResponseScreen(
//                   status: "false",
//                 )));
//       }
// */
//
//       // if (routeMessage == "transaction") {
//       //   // check user is login or not and check user is logout
//       //   // if logout then open mobile screen
//       //   //else open transaction screen and call first refresh token api
//       //   // Get.toNamed(AppPages.TRANSACTION);
//       //   Navigator.of(context)
//       //       .push(MaterialPageRoute(builder: (context) => PaymentScreen()));
//       // } else {
//       //   //Get.toNamed(AppPages.MPINSCREEN);
//       //   Navigator.of(context)
//       //       .push(MaterialPageRoute(builder: (context) => MPinScreen()));
//       //   // Get.toNamed(AppPages.TRANSACTION);
//       // }
//       // if (routeMessage == "true") {
//       //   // check user is login or not and check user is logout
//       //   // if logout then open mobile screen
//       //   //else open transaction screen and call first refresh token api
//       //   //  debugPrint("mandate notification"+ routeMessage ?? "");
//       //   debugPrint('routeMessage: ' + '$routeMessage');
//       // } else {
//       //   Navigator.of(context)
//       //       .push(MaterialPageRoute(builder: (context) => MPinScreen()));
//       //   // Get.toNamed(AppPages.MPINSCREEN);
//       // }
//       debugPrint('routeMessage: ' + '$routeMessage');
//       print(routeMessage ?? "");
  //  });
  } catch (e) {
    print(e);
  }
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('de', 'DE')],
      path: 'assets/translations',
      // <-- change the path of the translation files
      fallbackLocale: Locale('en', 'US'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: homeRoute,
      home: Splash(),
      theme: ThemeData(
          primaryColor: Colors.black,
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: DefaultColor.underlineGrey)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: DefaultColor.underlineGrey)),
          )),
      builder: EasyLoading.init(),

    );
  }
}

