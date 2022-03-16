import 'dart:io';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gmoney/bloc/bank_details_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewAgreement extends StatefulWidget {
  final webUrl;

  const NewAgreement({Key? key, this.webUrl}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewAgreementState();
  }
}
class NewAgreementState extends State<NewAgreement>{

  late final WebViewController webViewController ;
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    bankDetailsBloc.postAgreementUrl(Map());
    super.initState();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    JavascriptChannel _extractDataJSChannel(BuildContext context) {
      return JavascriptChannel(
        name: 'Flutter',
        onMessageReceived: (JavascriptMessage message) {
          String pageBody = message.message;
          print('page body: $pageBody');
        },
      );
    }
    return Scaffold(
        body: StreamBuilder<String>(
            stream: bankDetailsBloc.urlAgreementStream,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator());
              }
              return WebView(
                // initialUrl:"https://codelabs.developers.google.com/codelabs/flutter-webview#3",
                initialUrl:snapshot.data,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController w) {
                  webViewController = w;
                },
                debuggingEnabled: true,
                gestureNavigationEnabled: true,
                javascriptChannels: <JavascriptChannel>[
                  _extractDataJSChannel(context),
                ].toSet(),
                onProgress: (int progress){
                  print(progress);
                },
                onPageFinished: (String url) async {
                  print("object");
                  print(url);

                  // if (url.contains('/finalresponse.html')) {
                  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
                  //   print("event from notifications ${event.notification?.body}");
                  // });
                  if(url.contains("https://www.gmoney.loans") || url.contains("https://www.gmoney.in")) {
                    Navigator.of(context).pop();
                    print("code4living");
                    var html = await webViewController.runJavascriptReturningResult(
                        "window.document.getElementsByTagName('html')[0].outerHTML;");

                    print('printing whole webpage');
                    log(html);
                    // print(html);
                    // webViewController.runJavascript("(function(){Flutter.postMessage(window.document.body.outerHTML)})();");
                  }
                  /*  if(url.contains("flutter-webview#4")){
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/TutorialScreens', (Route<dynamic> route) => false);
              }*/
                  // print("object");


                },

              );
            }
        )
    );
  }

}
