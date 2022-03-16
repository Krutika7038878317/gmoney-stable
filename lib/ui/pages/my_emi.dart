import 'package:flutter/material.dart';
import 'package:gmoney/util/utils.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyEMIs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 4,
              decoration: new BoxDecoration(
                  color: DefaultColor.lightGrey,
                  gradient: new LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      DefaultColor.blueDark,
                      DefaultColor.blueLightGradient
                    ],
                  ))),
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
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
            padding: const EdgeInsets.only(top: 80),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    color: DefaultColor.appBarWhite,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20, left: 20, right: 15),
                          child: Text(
                            "Wockhardt Hospital",
                            style: TextStyle(
                                color: DefaultColor.blueDarkLogin,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 20),
                          child: Text("Procedure: Heart transplant",
                              style: TextStyle(
                                  color: DefaultColor.blackSubText,
                                  fontSize: 12)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 20),
                          child: Text(
                            "Amount: 1,00,000",
                            style: TextStyle(
                                color: DefaultColor.blackSubText, fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 20),
                          child: Text(
                            "Amount: 1,00,000",
                            style: TextStyle(
                                color: DefaultColor.blackSubText, fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          child: Text(
                            "6 installments of Rs. 1,00,000",
                            style: TextStyle(
                                color: DefaultColor.blueDarkLogin,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                  child: TimelineTile(
                                      axis: TimelineAxis.vertical,
                                      afterLineStyle:
                                          LineStyle(color: DefaultColor.green,thickness: 2),
                                      beforeLineStyle: LineStyle(
                                          color: DefaultColor.green,thickness: 2),
                                      isFirst: index == 0 ? true : false,
                                      isLast: index == 4 ? true : false,
                                      hasIndicator: true,
                                      endChild: Padding(
                                        padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Paid",style: TextStyle(
                                                color: DefaultColor.blueDarkLogin,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 5),
                                              child: Text("Amount: Rs. 30,000",style: TextStyle(
                                                  color: DefaultColor.blueDarkLogin,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 5),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Due date: 15th Oct’21",style: TextStyle(
                                                      color: DefaultColor.blueDarkLogin,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal),),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: Text("Paid on: 15th Oct’21",style: TextStyle(
                                                        color: DefaultColor.blueDarkLogin,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.normal),),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      alignment: TimelineAlign.start,
                                      indicatorStyle: IndicatorStyle(
                                        drawGap: true,
                                        indicatorXY: 0.2,
                                        height: 10,
                                        width: 10
                                      )),
                                );
                              },
                              itemCount: 5,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: 5,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
