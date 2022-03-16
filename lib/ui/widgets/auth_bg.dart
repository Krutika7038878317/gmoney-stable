import 'package:flutter/material.dart';
import 'package:gmoney/util/utils.dart';



class AuthBg extends StatelessWidget {
  final double ratio;
  final Widget topView,bottomView;
  AuthBg({required this.topView,required this.bottomView,required this.ratio});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(25.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/this.ratio,color: DefaultColor.appLightBlue,
          child: this.topView,),
          Container(
            padding: EdgeInsets.all(25.0),
            width: MediaQuery.of(context).size.width,
          child: this.bottomView,)
        ],
      ),
    );
  }
}
