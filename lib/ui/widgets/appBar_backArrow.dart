import 'package:flutter/material.dart';
import 'package:gmoney/util/utils.dart';




class AppBarBackArrow extends StatelessWidget{


  final String title;
  final VoidCallback onTap;
  AppBarBackArrow({required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
              constraints: BoxConstraints(),
              onPressed: onTap, icon: Icon(Icons.arrow_back_ios,color: DefaultColor.appBarWhite,)),
          Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: DefaultColor.appBarWhite),)
        ],
      ),
    );
  }

}
