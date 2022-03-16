import 'package:flutter/material.dart';
import 'package:gmoney/bloc/my_bills/my_bills_bloc.dart';
import 'package:gmoney/models/my_bills_model.dart';
import 'package:gmoney/ui/widgets/CommonCustomBg.dart';
import 'package:gmoney/ui/widgets/app_button.dart';
import 'package:gmoney/ui/widgets/my_bill_widgets/select_card.dart';
import '../../../util/utils.dart';
import '../../widgets/appBar_backArrow.dart';



class MyBillsDetails extends StatelessWidget {
  final index;
  static const bool? isChecked = false;

  MyBillsDetails({this.index});

  Widget _row14(String text1,String text2){
    return Padding(
      padding: const EdgeInsets.only(top: 8,bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(text1,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)),
          Expanded(child: Text(text2,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),))
        ],),
    );
  }

  Widget _emiDialog(List<EmiTable>? _emiDataList){
    return Dialog(
      insetPadding: EdgeInsets.all(15),
      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text("EMI Table",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
            DataTable(sortColumnIndex: 1,sortAscending:true,columns: [
              DataColumn(label: Text("Sr")),
              DataColumn(label: Text("Date")),
              DataColumn(label: Text("Rupees"))
            ], rows:
                _emiDataList!.map((data) =>
                   DataRow(cells: [
                      DataCell(Text("${_emiDataList.indexOf(data)+1}")),
                      DataCell(Text("${dateConversion(data.emiDate.toString())}")),
                      DataCell(Text(data.emiAmount.toString()))
                  ])
                ).toList()
            )
          ],
        ),
      ),
    );
  }
  Widget _emiTableTxt(BuildContext context,List<EmiTable>? _emiData){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10,top: 10),
      child: GestureDetector(
        onTap: ()=> showDialog(context: context, builder: (_){
          return _emiDialog(_emiData);
        }),
        child: Text("EMI Table",  style: TextStyle(
            decoration: TextDecoration.underline,
            color: DefaultColor.blueDark,
            fontSize: 16,fontWeight: FontWeight.w500
        ),),
      ),
    );
  }
  Widget _checkBoxUI() {
    return StreamBuilder<bool?>(
      initialData: false,
      stream: myBillsBloc.getPolicyCheckBox,
      builder: (context, snapshot) {
        return CheckboxListTile(
            contentPadding: EdgeInsets.all(0),
            activeColor: DefaultColor.blueDark,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              "I hereby consent to the privacy policy",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Utils.getColorFromHex("#464646")),
            ),
            value: snapshot.data,
            onChanged: (val) {
                myBillsBloc.updatePolicyCheckBox.add(val);
            });
      }
    );
  }
  Widget _confirmationDialog(BuildContext context){
    return Dialog(
      insetPadding: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
            children: [
              Text("Are you want to decline",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              SizedBox(height: MediaQuery.of(context).size.height/18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                Text("No"),
                Text("Yes")
              ],)
            ],
        ),
      ),
    );
  }
  Widget _buttons(BuildContext context){
    return Container(
      child: Row(children: [
        Expanded(child: AppButton(onTap: (){
          showDialog(context: context, builder: (_){
            return _confirmationDialog(context);
          });
        },buttonTitle: "Decline",)),
        SizedBox(width: 12,),
        Expanded(child: AppButton(onTap: (){
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
              ),
              context: context, builder: (_){
            return SelectCard();
          });
        },buttonTitle: "Proceed",))
      ],),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultColor.scaffoldBgWhite,
      body: SingleChildScrollView(
        child: CommonCustomBG(
          widgetsOverGradient: AppBarBackArrow(title: "My Bills", onTap: ()=> Navigator.pop(context)),
          widgetOverCard: StreamBuilder<MyBillsModel>(
            stream: myBillsBloc.getMyBillsData,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Utils.instance.loader(context);
              }
              var _data = snapshot.data!.data![this.index];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_data.merchant!.name ??"Wockhardt Hospital",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    SizedBox(height: 10,),
                    _row14("Category", _data.category!.name?? "Cardic Value Replacement",),
                    _row14("Procedure:", _data.procedure!.name??"cardic Value Replacement"),
                    _row14("Admission Date:", Utils.instance.dateFormation(_data.offer!.admissionDate!)),
                    _row14("Amount:", _data.offer!.loanAmount.toString()),
                    _row14("Total EMI:", _data.loanCalculation!.totalEmiCount.toString()),
                    _row14("EMI Amount:", _data.loanCalculation!.emiAmount.toString()),
                    _row14("Advance EMI count:", _data.loanCalculation!.advanceEmiCount.toString()),
                    _row14("Advance EMI amount:", _data.loanCalculation!.advanceEmiAmt.toString()),
                    _row14("Balance EMI count:", _data.loanCalculation!.emiTable!.length.toString()),
                    _row14("Balance EMI amount:", "${_data.loanCalculation!.balanceEmiAmt??"₹ 10,000"}"),
                    _row14("EMI start date:", "${dateConversion(_data.loanCalculation!.emiTable!.first.emiDate.toString())}"),
                    _row14("EMI end date:", "${dateConversion(_data.loanCalculation!.emiTable!.last.emiDate.toString())}"),
                    _row14("processing fee:", "${_data.loanCalculation!.processingFee??"₹ 10,000"}"),
                    _row14("HSP Bank Name:", "${_data.merchant!.bankDetails!.bankName??"Oriental Bank of Commerce"}"),
                    _row14("HSP IFSC no:", "${_data.merchant!.bankDetails!.ifsc??"HDFC00003210"}"),
                    _row14("HSP Acc. no:", "${_data.merchant!.bankDetails!.accountNo??"2145257835211526"}"),
                    _emiTableTxt(context,_data.loanCalculation!.emiTable),
                    _checkBoxUI(),
                    _buttons(context)
                  ],
                ),
              );
            }
          ),
          screenWidgets: SizedBox(height: 20,),
        ),
      ),
    );
  }
}
String dateConversion(String _date){
  List<String> splittedStartDate = _date.split("-");
  final RegExp regexp = new RegExp(r'^0+(?=.)');
  int withoutZero = int.parse(splittedStartDate[0].replaceAll(regexp, ""));
  String resultDate = splittedStartDate[1]+" "+myBillsBloc.months[withoutZero-1]+" "+splittedStartDate[2];
  return resultDate;
}