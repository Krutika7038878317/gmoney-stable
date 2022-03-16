import 'package:flutter/material.dart';
import 'package:gmoney/util/utils.dart';




class BottomSheetBills extends StatelessWidget {
  const BottomSheetBills({Key? key}) : super(key: key);

  Widget textAndPic(String text,String icon){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Image.asset(icon),
          SizedBox(height: 30,),
          Text(text,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: DefaultColor.blackSubText),)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){Navigator.pushNamed(context, "/MyBillsScreen").then((value) =>Navigator.pop(context));},
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),color: DefaultColor.appBarWhite,),
              margin: EdgeInsets.fromLTRB(15,0,7,80),
              height: 190,
              child: textAndPic("Bill", "assets/images/bills.png"),
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),color: DefaultColor.appBarWhite,),
            margin: EdgeInsets.fromLTRB(7,0,15,80),
            height: 190,
            child: textAndPic("Processing Fee", "assets/images/processing_fee.png"),
          ),
        ),
      ],
    );
  }
}
