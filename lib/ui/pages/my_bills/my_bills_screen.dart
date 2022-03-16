import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gmoney/models/my_bills_model.dart';
import 'package:gmoney/ui/widgets/CommonCustomBg.dart';
import 'package:gmoney/ui/widgets/appBar_backArrow.dart';
import 'package:gmoney/util/utils.dart';

import '../../../bloc/my_bills/my_bills_bloc.dart';





class MyBillsScreen extends StatelessWidget {
  const MyBillsScreen({Key? key}) : super(key: key);

  Widget descriptionUI(BuildContext context,Data _dataParams,int _index){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(alignment: Alignment.topRight,child: Container(
          margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomLeft: Radius.circular(15)),color: DefaultColor.appDarkBlue,),
          padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: Text(_dataParams.offer!.check!.status ?? "New",style: TextStyle(color: DefaultColor.appBarWhite),),
        ),),
          Text(_dataParams.merchant!.name ?? "Wockhardt Hospital",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
          SizedBox(height: 25,),
          Row(
            children: [
            Expanded(child: Text("Category:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)),
              Expanded(child: Text("Amount:",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),))
          ],),
        SizedBox(height: 5,),
        Row(
          children: [
            Expanded(child: Text(_dataParams.category!.name??"Health checkup",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),)),
            Expanded(child: Text(_dataParams.offer!.loanAmount.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),))
          ],),
        SizedBox(height: 25,),
        Text("Date:"),
        SizedBox(height: 5,),
        Text(Utils.instance.dateFormation(_dataParams.offer!.admissionDate!)),
        SizedBox(height: 25,),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/MyBillsDetails",arguments: _index),
          child: Align(alignment: Alignment.center,child: Text("View details",  style: TextStyle(
            decoration: TextDecoration.underline,
            color: DefaultColor.blueDark,
            fontSize: 17,fontWeight: FontWeight.w500
          ),),),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColor.scaffoldBgWhite,
      body: SingleChildScrollView(
        child: CommonCustomBG(
          cardTopPadding: 8.5,
          widgetsOverGradient: AppBarBackArrow(title: "My Bills", onTap: ()=> Navigator.pop(context)),
          isCardOnTop: false,
          screenWidgets: StreamBuilder<MyBillsModel>(
            stream: myBillsBloc.getMyBillsData,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                  return Utils.instance.loader(context);
              }
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.fromLTRB(20,0,0,20),
                    margin: EdgeInsets.only(bottom: 15),decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),color: Utils.getColorFromHex("#FFFFFF")
                ),child: descriptionUI(context,snapshot.data!.data![index],index));
              });
            }
          )
        ),
      ),
    );
  }
}
