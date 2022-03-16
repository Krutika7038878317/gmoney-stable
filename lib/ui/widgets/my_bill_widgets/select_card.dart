import 'package:flutter/material.dart';
import 'package:gmoney/ui/widgets/app_button.dart';
import 'package:gmoney/util/utils.dart';

import '../../../bloc/my_bills/my_bills_bloc.dart';





class SelectCard extends StatelessWidget {
  static const int _groupValue = -1;

 Widget _row(String _cardNumber ,int _index, String _cardImg){
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        SizedBox(
            height: 20,width: 20,
            child: Radio(value: _index, groupValue: _groupValue, onChanged: (_){})),
        SizedBox(width: 10,),
        Expanded(child: Text(_cardNumber,style: TextStyle(
            fontSize: 16,fontWeight: FontWeight.w400,letterSpacing: 1.5),)),
        Container(
          height: 36,width: 56,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: DefaultColor.grey),)
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      height: MediaQuery.of(context).size.height/3,
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: myBillsBloc.myCards.length,
                itemBuilder: (context,index){
                  return _row(myBillsBloc.myCards[index].cardNumber, myBillsBloc.myCards[index].index,
                      myBillsBloc.myCards[index].cardImg);
            }),
          ),
          SizedBox(height: 20,),
          AppButton(onTap: (){Navigator.pushNamed(context, "/MyBillsOtp").then((value) => Navigator.pop(context));},buttonTitle: "Request to Pay",)
        ],
      ),
    );
  }
}
