import 'package:flutter/material.dart';
import 'package:gmoney/ui/widgets/CommonCustomBg.dart';
import 'package:gmoney/ui/widgets/appBar_backArrow.dart';
import 'package:gmoney/ui/widgets/app_button.dart';
import 'package:gmoney/util/utils.dart';

import '../../widgets/otp_code_field.dart';



class MyBillsOtp extends StatelessWidget {
  const MyBillsOtp({Key? key}) : super(key: key);

  Widget thankYouUI(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("Thank you for using GMoney !!! Please wait for approval",
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: AppButton(onTap: (){},buttonTitle: "Ok",),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColor.scaffoldBgWhite,
      body: CommonCustomBG(
            widgetsOverGradient: AppBarBackArrow(title: "My Bills", onTap: ()=>Navigator.pop(context)),
            widgetOverCard: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Please enter the OTP sent on your registered mobile number",
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                ),
              OtpCodeField(
                  length: 4,
                  isFrom: "MPinField",
                  isEnabled: true),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AppButton(onTap: (){},buttonTitle: "Submit",),
                )
              ],
            ),
      ),
    );
  }
}
