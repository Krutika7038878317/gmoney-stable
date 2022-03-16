import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmoney/util/utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../bloc/otp_bloc.dart';

class OtpCodeField extends StatefulWidget {
  int? length;
  bool? isEnabled =true;
 final String? isFrom;



   OtpCodeField({Key? key, this.isEnabled, this.isFrom, this.length}) : super(key: key);

  @override
  State<OtpCodeField> createState() => _OtpCodeFieldState();
}

class _OtpCodeFieldState extends State<OtpCodeField> {
  TextEditingController textEditingController =TextEditingController();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  @override
  Widget build(BuildContext context) {
    bool hasError = false;
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
      child: PinCodeTextField(
        appContext: context,
        enabled: widget.isEnabled!,
        pastedTextStyle: TextStyle(
          color: DefaultColor.blueMobile,
          fontWeight: FontWeight.bold,
        ),
        length: widget.length == null || widget.length == 0 ? 4 : widget.length!,
        autoFocus: false,
        obscureText: false,
        obscuringCharacter: '*',
        animationType: AnimationType.fade,
        // validator: (v) {
        //   if (v!=null||v!.length < 3) {
        //     return "I'm from validator";
        //   } else {
        //     return "";
        //   }
        // },
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          fieldHeight: widget.length == null || widget.length == 0 || widget.length == 4
              ? MediaQuery.of(context).size.width / 7
              : MediaQuery.of(context).size.width / 10,
          fieldWidth: widget.length == null || widget.length == 0 || widget.length == 4
              ? MediaQuery.of(context).size.width / 6
              : MediaQuery.of(context).size.width / 15,
          activeFillColor: hasError ? Color(0xFFFAFAFA) : Color(0xFFFAFAFA),
          inactiveFillColor: Color(0xFFFAFAFA),
          selectedColor: DefaultColor.blueMobile,
          selectedFillColor: Color(0xFFFAFAFA),
          inactiveColor: Color(0xFFA6A6A6),
          activeColor: Color(0xFFA6A6A6),
          disabledColor: Color(0xFFFAFAFA), // isDisabled
        ),
        cursorColor: DefaultColor.blueMobile,
        animationDuration: Duration(milliseconds: 300),
        textStyle: TextStyle(fontSize: 14, height: 2.1),
//                            backgroundColor: Colors.blue.shade50,
        enableActiveFill: true,
        errorAnimationController: errorController,
        controller: textEditingController,
        keyboardType: const TextInputType.numberWithOptions(signed: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        useHapticFeedback: true,
        autoDismissKeyboard: true,
        textInputAction: TextInputAction.done,
//                            boxShadows: [
//                              BoxShadow(
//                                offset: Offset(0, 1),
//                                color: Colors.black12,
//                                blurRadius: 10,
//                              )
//                            ],
        onCompleted: (v) {
          print("Completed");
        },
        // onTap: () {
        //   print("Pressed");
        // },
        onChanged: (value) {
          print("pin code value >>>>" + value);
         if(widget.isFrom=="Login"){
           otpBloc.loginOtpSink.add(value.toString());
         }
          if(widget.isFrom=="CreateMPinFieldOne"){
            otpBloc.mPinFieldOneSink.add(value.toString());
          }
          if(widget.isFrom=="CreateMPinFieldTwo"){
            otpBloc.mPinFieldTwoSink.add(value.toString());
          }
          if(widget.isFrom=="MPinField"){
            otpBloc.mPinAuthSink.add(value.toString());
          }
          if(widget.isFrom=="Agreement"){
            otpBloc.agreementSink.add(value.toString());
          }
          if(widget.isFrom=="AadhaarDetails"){
            print("pin code valuesss >>>>" + value);
            otpBloc.aadhaarDetailsSink.add(value.toString());
          }
          /*setState(() {
            currentText = value;
          });*/
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      ),
    );
  }
}
