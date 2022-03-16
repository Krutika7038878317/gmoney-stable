import 'package:flutter/material.dart';
import 'package:gmoney/util/utils.dart';



class AppButton extends StatelessWidget {
  final buttonTitle;
  final buttonColour;
  final VoidCallback onTap;
  AppButton({this.buttonTitle,required this.onTap,this.buttonColour});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: buttonColour==null?DefaultColor.appDarkBlue:buttonColour,borderRadius: BorderRadius.circular(10)),
        height: 55,width: MediaQuery.of(context).size.width,child: Text(this.buttonTitle??"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.white),),),
    );
  }
}
