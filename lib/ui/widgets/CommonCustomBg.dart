import 'package:flutter/material.dart';
import 'package:gmoney/util/utils.dart';


class CommonCustomBG extends StatelessWidget {
  final num? cardTopPadding;
  final  screenWidgets;
  final   widgetsOverGradient;
  final widgetOverCard;
  final bool? isCardOnTop;
  CommonCustomBG({this.screenWidgets,this.widgetOverCard,this.cardTopPadding, this.widgetsOverGradient,this.isCardOnTop});

  Widget gradientTopWidget(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/4.1,
      decoration: BoxDecoration(gradient: DefaultColor.linearGradient),
      child: widgetsOverGradient);

  }
  @override
  Widget build(BuildContext context) {
    // double padd = 6.8;
    return Stack(
        children: [
          gradientTopWidget(context),
          Container(
           margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              children: [
                SizedBox(height: cardTopPadding != null ? MediaQuery.of(context).size.height/cardTopPadding!:MediaQuery.of(context).size.height/6.8,),
               this.isCardOnTop == null ? Container(decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),color: Utils.getColorFromHex("#FFFFFF")
                ),child: widgetOverCard ?? Container(height: 220,)): Container(),
                this.screenWidgets ?? Container()
              ],
            ),
          )
        ],
      );
  }
}

