import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gmoney/bloc/liveness_bloc.dart';
import 'package:gmoney/bloc/selfie_upload_bloc.dart';

import '../models/liveness_face_model.dart';
import '../util/utils.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  void checkLiveNess() async {
    final bytes = await File(widget.imagePath).readAsBytesSync();
    String img64 = await base64Encode(bytes);
    print(img64);
    var response = await liveNessBloc.faceData(img64);
    print('responses');
    print(response);
    if (response is LivenessFaceModel) {
      print('response');
      print('isFaceCropped');
      print(response.result.isFaceCropped);
      print('isLive');
      print(response.result.isLive);
      print('reviewRequired');
      print(response.result.reviewRequired);
    } else {
      print('response error');
      print(response);
    }
  }

  @override
  void initState() {
    print('InitState');
    checkLiveNess();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image.file(
                File(widget.imagePath),
                fit: BoxFit.fitWidth,
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Image.asset(
                "assets/images/Subtract.png",
                fit: BoxFit.cover,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Image.asset(
                "assets/images/Subtract.png",
                fit: BoxFit.cover,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              StreamBuilder<LivenessFaceModel>(
                  stream: liveNessBloc.liveNessDataStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.60,
                          ),
                          snapshot.data!.result.isLive == null ||
                                  snapshot.data!.result.isLive == false ||
                                  snapshot.data!.result.reviewRequired ==
                                      null ||
                                  snapshot.data!.result.reviewRequired == true
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 40),
                                  child: Text(
                                      "Image is not proper. please retake your selfie",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: DefaultColor.redText,
                                        fontSize: 16,
                                      )),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 40),
                                  child: Text(
                                      "This image will be used as your profile picture ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: DefaultColor.greenText,
                                        fontSize: 16,
                                      )),
                                ),
                          SizedBox(
                            height: 20,
                          ),
                          Spacer(),
                          snapshot.data!.result.isLive == null ||
                                  snapshot.data!.result.isLive == false ||
                                  snapshot.data!.result.reviewRequired ==
                                      null ||
                                  snapshot.data!.result.reviewRequired == true
                              ? Center(
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    child: OutlinedButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                       /* Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                        '/HomeScreen',
                                        (Route<dynamic> route) =>
                                        false);*/
                                      },
                                      child: Text(
                                        "Retake",
                                        style: TextStyle(
                                            color: DefaultColor.blueDark,
                                            fontSize: 16),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            width: 2.0,
                                            color: DefaultColor.blueDark),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                      ),
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Center(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: OutlinedButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Retake",
                                            style: TextStyle(
                                                color: DefaultColor.blueDark,
                                                fontSize: 16),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                width: 2.0,
                                                color: DefaultColor.blueDark),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        child: OutlinedButton(
                                          onPressed: () async {
                                            var data = {
                                              "file": File(widget.imagePath)
                                            };
                                            var response =
                                                await selfieUploadBloc
                                                    .uploadSelfie(data, [File(widget.imagePath)]);
                                            print('responseData');
                                            print(response);
                                            if (response == true) {
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      '/HomeScreen',
                                                      (Route<dynamic> route) =>
                                                          false);
                                            }
                                          },
                                          child: Text(
                                            "Continue",
                                            style: TextStyle(
                                                color: DefaultColor.appBarWhite,
                                                fontSize: 16),
                                          ),
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsets>(
                                                EdgeInsets.symmetric(
                                                    vertical: 15)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    DefaultColor.blueDark),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 25,
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
            ],
          )),
    );
  }
}
