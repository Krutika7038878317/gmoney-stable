import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gmoney/bloc/aadhar_bloc.dart';
import 'package:gmoney/bloc/consumer_home.dart';
import 'package:gmoney/ui/widgets/CommonCustomBg.dart';
import 'package:gmoney/ui/widgets/aadhaar/bottomSheetPicker.dart';
import 'package:gmoney/ui/widgets/appBar_backArrow.dart';
import 'package:gmoney/ui/widgets/app_button.dart';
import 'package:gmoney/ui/widgets/otp_code_field.dart';
import 'package:gmoney/util/utils.dart';

import '../../../bloc/otp_bloc.dart';

class AadhaarDetails extends StatefulWidget {
  @override
  State<AadhaarDetails> createState() => _AadhaarDetailsState();
}

class _AadhaarDetailsState extends State<AadhaarDetails> {
  TextEditingController _adharController = TextEditingController(text: "");
  TextEditingController _aadhaarAddressController =
      TextEditingController(text: "");
  TextEditingController _currentAddressController =
      TextEditingController(text: "");
  TextEditingController _otpController = TextEditingController(text: "");

  bool? isChecked = false;
  List<String?> allImages = [];

  String frontImage = '';
  String backImage = '';
  String addressImage = '';

  int _counter = 0;
  late StreamController<int> _events;

  @override
  initState() {
    super.initState();
    _events = new StreamController<int>.broadcast();
    _events.add(30);
  }

  @override
  void dispose() {
    _events.close();
    _aadhaarAddressController.dispose();
    _currentAddressController.dispose();
    aadhaarBloc.dispose();
    super.dispose();
  }

  static late Timer _timer;

  void _startTimer() {
    _counter = 30;
    /*  if (_timer != null) {
      _timer.cancel();
    }*/
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //setState(() {
      (_counter > 0) ? _counter-- : _timer.cancel();
      //});
      print(_counter);
      _events.add(_counter);
    });
  }

  Widget pdfUI(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            backgroundColor: Colors.transparent,
            context: context,
            builder: (_) {
              return BottomSheetPicker(
                place: 0,
                showFile : false
              );
            });
      },
      child: DottedBorder(
        color: Color(0xFFB5EAFF),
        strokeWidth: 1,
        radius: Radius.circular(5),
        borderType: BorderType.RRect,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                color: Color(0x335DFE7EB),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Image.asset(
                  "assets/images/upload_pdf.png",
                  fit: BoxFit.fitHeight,
                )),
            // Divider(),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              color: Color(0x117AD5F9),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                "Upload Aadhaar Front",
                style: TextStyle(
                    color: Color(0xFF014078),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget pdfUIBack(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            backgroundColor: Colors.transparent,
            context: context,
            builder: (_) {
              return BottomSheetPicker(
                place: 1,
                  showFile : false
              );
            });
      },
      child: DottedBorder(
        color: Color(0xFFB5EAFF),
        strokeWidth: 1,
        radius: Radius.circular(5),
        borderType: BorderType.RRect,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                color: Color(0x335DFE7EB),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Image.asset(
                  "assets/images/upload_pdf.png",
                  fit: BoxFit.fitHeight,
                )),
            // Divider(),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              color: Color(0x117AD5F9),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                "Upload Aadhaar Back",
                style: TextStyle(
                    color: Color(0xFF014078),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget pdfUIPreview(BuildContext context) {
    return StreamBuilder<String?>(
        stream: consumerHome.getImgPath,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          ;
          if (snapshot.hasData && snapshot.data!.length > 0) {
            frontImage = snapshot.data!;
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 70,
                      width: 60,
                      color: Color(0x335DFE7EB),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Image.file(File(snapshot.data!),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                        right: 5,
                        top: 5,
                        child: GestureDetector(
                            onTap: () {
                              consumerHome.updateImgPath.add('');
                            },
                            child: Text(
                              'X',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Aadhaar front'),
                )
              ],
            );
          }
          return Container();
        });
  }

  Widget pdfUIBackPreview(BuildContext context) {
    return StreamBuilder<String?>(
        stream: consumerHome.getImgPathBack,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          ;
          if (snapshot.hasData && snapshot.data!.length > 0) {
            backImage = snapshot.data!;
            print('backImage');
            print(backImage);
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 70,
                      width: 60,
                      color: Color(0x335DFE7EB),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Image.file(File(snapshot.data!),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                        right: 5,
                        top: 5,
                        child: GestureDetector(
                            onTap: () {
                              consumerHome.updateImgPathBack.add('');
                            },
                            child: Text(
                              'X',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Aadhaar back'),
                )
              ],
            );
          }
          return Container();
        });
  }

  Widget _textFiled() {
    return TextField(
      controller: _adharController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12),
      ],
      decoration: InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: "Please enter Aadhaar card number",
          hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Utils.getColorFromHex("#A6A6A6"))),
    );
  }

  Widget pdfUICurrent(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            backgroundColor: Colors.transparent,
            context: context,
            builder: (_) {
              return BottomSheetPicker(
                place: 2,
                  showFile : false
              );
            })
      },
      child: StreamBuilder<String?>(
          stream: consumerHome.getImgPathCurrent,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.length == 0) {
              return DottedBorder(
                color: Color(0xFFB5EAFF),
                strokeWidth: 1,
                radius: Radius.circular(5),
                borderType: BorderType.RRect,
                child: Row(
                  children: [
                    Container(
                        color: Color(0x335DFE7EB),
                        padding: const EdgeInsets.fromLTRB(18, 28, 18, 28),
                        child: Image.asset(
                          "assets/images/upload_pdf.png",
                          fit: BoxFit.fitHeight,
                        )),
                    Divider(),
                    Expanded(
                        child: Container(
                      color: Color(0x117AD5F9),
                      padding: const EdgeInsets.fromLTRB(18, 15, 8, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upload Current Address proof",
                            style: TextStyle(
                                color: Color(0xFF014078),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Maximum file size 5 MB (png, jpeg, jpg, pdf)",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF525252)),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              );
            }
            debugPrint("file >>>>>> ${snapshot.data!}");
            if (snapshot.data!.length > 0) {
              addressImage = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DottedBorder(
                    color: Color(0xFFB5EAFF),
                    strokeWidth: 1,
                    radius: Radius.circular(5),
                    borderType: BorderType.RRect,
                    child: Row(
                      children: [
                        Container(
                            color: Color(0x335DFE7EB),
                            padding: const EdgeInsets.fromLTRB(18, 28, 18, 28),
                            child: Image.asset(
                              "assets/images/upload_pdf.png",
                              fit: BoxFit.fitHeight,
                            )),
                        Divider(),
                        Expanded(
                            child: Container(
                          color: Color(0x117AD5F9),
                          padding: const EdgeInsets.fromLTRB(18, 15, 8, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Upload Current Address proof",
                                style: TextStyle(
                                    color: Color(0xFF014078),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Maximum file size 5 MB (png, jpeg, jpg, pdf)",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF525252)),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  snapshot.data!.length > 0
                      ? Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 70,
                                  width: 60,
                                  color: Color(0x335DFE7EB),
                                  //  padding: const EdgeInsets.fromLTRB(18,28,18,28),
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Image.file(File(snapshot.data!),
                                          fit: BoxFit.cover)),
                                ),
                                Positioned(
                                    right: 5,
                                    top: 5,
                                    child: GestureDetector(
                                        onTap: () {
                                          consumerHome.updateImgPathCurrent
                                              .add('');
                                        },
                                        child: Text(
                                          'X',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Address proof'),
                            )
                          ],
                        )
                      : Container(),
                ],
              );
            }
            return Container();
          }),
    );
  }

  Widget _checkBoxUI() {
    return CheckboxListTile(
        contentPadding: EdgeInsets.all(0),
        activeColor: DefaultColor.blueDark,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          "I authorize GMoney Pvt.Ltd to "
          "access my Aadhaar no. and help me"
          " fetch my details",
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Utils.getColorFromHex("#464646")),
        ),
        value: isChecked,
        onChanged: (_) {
          setState(() {
            isChecked = !isChecked!;
          });
        });
  }

  String otp = "";

  @override
  Widget build(BuildContext context) {
    var _textStyle = TextStyle(
        color: AadhaarColors.textGrey,
        fontSize: 14,
        fontWeight: FontWeight.w400);
    return Scaffold(
        backgroundColor: DefaultColor.scaffoldBgWhite,
        body: SingleChildScrollView(
          child: CommonCustomBG(
            cardTopPadding: 8,
            widgetsOverGradient: AppBarBackArrow(
                title: "Complete your KYC",
                onTap: () => Navigator.pop(context)),
            widgetOverCard: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aadhaar Details",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: DefaultColor.blueDarkLogin),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  Text("Verify aadhaar online", style: _textStyle),
                  SizedBox(height: 10),
                  _textFiled(),
                  SizedBox(height: 20),
                  AppButton(
                    onTap: () {
                      _startTimer();
                      if (_timer != null) validate(context);
                    },
                    buttonTitle: "Verify",
                    buttonColour: Utils.getColorFromHex("#014078"),
                  ),
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "OR",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: DefaultColor.blueDarkLogin),
                      )),
                  SizedBox(height: 30),
                  Text("Upload aadhar", style: _textStyle),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pdfUI(context),
                      pdfUIBack(context),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Maximum file size 5 MB (png, jpeg, jpg, pdf)",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF525252)),
                  ),
                  SizedBox(height: 15),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      pdfUIPreview(context),
                      pdfUIBackPreview(context),
                    ],
                  ),

                  //--/// vk //////

                  TextField(
                    controller: _aadhaarAddressController,
                    decoration: InputDecoration(
                        label: Text("Aadhaar address"),
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Please enter Aadhaar address",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Utils.getColorFromHex("#A6A6A6"))),
                  ),
                  SizedBox(height: 15),

                  Text("My Current Address is same as Aadhar"),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        value: 0,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                      ),
                      Text(
                        'Yes',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                      Radio(
                        value: 1,
                        groupValue: _radioValue1,
                        onChanged: _handleRadioValueChange1,
                      ),
                      Text(
                        'No',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  !_currentAddress
                      ? TextField(
                          controller: _currentAddressController,
                          decoration: InputDecoration(
                              label: Text("Current address"),
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.start,
                              // floatingLabelBehavior: FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Please enter Current address",
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Utils.getColorFromHex("#A6A6A6"))),
                        )
                      : Container(),
                  SizedBox(height: 10),
                  !_currentAddress ? pdfUICurrent(context) : Container(),

                  ///// vk /////--/
                  _checkBoxUI(),
                  SizedBox(height: 10),
                  AppButton(
                    onTap: () => uploadImages(context),
                    buttonTitle: "Next",
                    buttonColour: !isChecked!
                        ? Utils.getColorFromHex("#DCDCDC")
                        : DefaultColor.blueDark,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  validate(BuildContext context) {
    sendOtp(_adharController.text.toString());
    int secondsRemaining = 30;
    bool enableResend = false;
    Timer timer;

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        secondsRemaining--;

        // setState(() {
        // });
      } else {
        enableResend = true;

        // setState(() {
        // });
      }
    });

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: StreamBuilder<int>(
                stream: _events.stream,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  print(snapshot.data.toString());
                  return Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: const Color(0xFFFFFF),
                      /*       borderRadius:
                  BorderRadius.all(new Radius.circular(32.0)),*/
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // dialog top
                        Text(
                          'Please enter the OTP sent on your mobile number',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        OtpCodeField(
                            isEnabled: true,
                            isFrom: "AadhaarDetails",
                            length: 6),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () =>
                              sendOtp(_adharController.text.toString()),
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                text: 'Resend otp',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: DefaultColor.blackTC,
                                    decoration: TextDecoration.underline),
                                children: <TextSpan>[
                                  _counter != 0
                                      ? TextSpan(
                                          text:
                                              ' ( ${snapshot.data.toString()} sec)',
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                          ))
                                      : TextSpan(
                                          text: '',
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                          )),
                                  // can add more TextSpans here...
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        AppButton(
                          onTap: () => verify(context),
                          buttonTitle: "Submit",
                          buttonColour: Utils.getColorFromHex("#014078"),
                        ),
/*
                        StreamBuilder<String>(
                            stream: otpBloc.aadhaarDetailsStream,
                            builder: (context, snapshot) {
                              if(snapshot.hasData)  {
                                print("snap");
                                print(snapshot.data);
                                return   AppButton(
                                  onTap: () => verify(context),
                                  buttonTitle: "Submit",
                                  buttonColour: Utils.getColorFromHex("#014078"),
                                );
                              }
                              else{
                                return   AppButton(
                                  onTap: () => verify(context),
                                  buttonTitle: "Submit",
                                  buttonColour: Utils.getColorFromHex("#014078"),
                                );
                              }

                          }
                        ),
*/
                      ],
                    ),
                  );
                }),
          );
        }).then((value) {
      print('dismissed');
      _timer.cancel();
    });
  }

  sendOtp(String aadharNo) {
    if (aadharNo.length > 11) {
      var data = {
        'aadhar_number': aadharNo,
      };
      aadhaarBloc.sendOtp(data);
    } else {
      Utils.instance.showToast("Please enter 12 digit aadhaar number");
    }
  }

  verify(BuildContext context) async {
    print('otp');
    print(otp);
    await otpBloc.aadhaarDetailsStream.listen((event) {
      print('otp event ');
      otp = event;
      print(otp);
    });
    var data = {
      'aadharotp': otp,
    };
    if (otp != null && otp.length == 6) {
      var a = await aadhaarBloc.verifyOtp(data);
      print(a);
      if (a == true) Navigator.of(context).pop();
    } else {
      print("enter valid otp");
      Utils.showErrorMessage("Please enter valid otp");
    }
  }

  uploadImages(BuildContext context) async {
    List<File> files = [];
    /*allImages.forEach((element) {
      files.add(File(element!));
      files.add(File(element!));
    });*/
    Map<String, File> fileMap = Map();
    if (frontImage != null && frontImage.isNotEmpty)
      files.add(File(frontImage));
    if (backImage != null && backImage.isNotEmpty) files.add(File(backImage));
    if (addressImage != null && addressImage.isNotEmpty) {
      // files.add(File(addressImage));
      fileMap = {'current_address_img': File(addressImage)};
    }

    print("call1");
    print(files);
    if (files.isNotEmpty && isChecked!) {
      var data = {
        "aadhaar_address": _aadhaarAddressController.text,
        "current_address": _currentAddressController.text
      };
      EasyLoading.show(status: 'loading...');

      await aadhaarBloc
          .fetchAadhaarUploadData(data, files, fileMap)
          .then((value) {
        print("success");
        EasyLoading.dismiss();
        Navigator.pop(context);
      }).catchError((onError) {
        EasyLoading.dismiss();
        print("failed");
      }).onError((error, stackTrace) {
        EasyLoading.dismiss();
      });
    } else {
      print("call2");
      Utils.showErrorMessage("Please select files and accept the terms.");
    }
  }

  int _radioValue1 = 0;
  bool _currentAddress = true;

  // int _radioValue1 = useState(0);

  void _handleRadioValueChange1(int? value) {
    setState(() {
      _radioValue1 = value!;
      if (value == 1)
        _currentAddress = false;
      else
        _currentAddress = true;
    });
  }
}
