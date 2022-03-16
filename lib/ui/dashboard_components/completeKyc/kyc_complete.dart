
import 'package:flutter/material.dart';
import 'package:gmoney/bloc/otp_bloc.dart';
import 'package:gmoney/util/utils.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bloc/authentication_bloc.dart';
import '../../widgets/app_button.dart';
import '../../widgets/otp_code_field.dart';

class KycCompleteScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColor.lightGrey,
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: new BoxDecoration(
                  color: DefaultColor.lightGrey,
                  gradient: new LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [DefaultColor.blueDark, DefaultColor.blueLightGradient],
                  ))),
          Column(
            children: [

              Expanded(
                flex: 6,
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height/10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  otpBloc.otpAgreementNotifier.add("");
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                      '/HomeScreen',
                                          (Route<dynamic>
                                      route) =>
                                      false);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: DefaultColor.appBarWhite,
                                )),
                            Text(
                              "Complete your KYC",
                              style: TextStyle(
                                  color: DefaultColor.appBarWhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        color: DefaultColor.appBarWhite,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                            padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "Your KYC is completed \n"
                                    "successfully !!!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: DefaultColor.blueDarkLogin,
                                    fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: AppButton(
                                onTap: (){
                                  otpBloc.otpAgreementNotifier.add("");
                                  Navigator.of(context)
                                      .pushNamedAndRemoveUntil(
                                      '/HomeScreen',
                                          (Route<dynamic>
                                      route) =>
                                      false);
                                },
                                buttonTitle: "Ok",
                                buttonColour: Utils.getColorFromHex("#014078"),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );

  }

}

