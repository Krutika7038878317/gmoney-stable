import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gmoney/bloc/consumer_home.dart';
import 'package:gmoney/models/faq_res_model.dart';
import 'package:gmoney/ui/widgets/CommonCustomBg.dart';
import 'package:gmoney/ui/widgets/appBar_backArrow.dart';
import 'package:gmoney/util/utils.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  Widget faqUI(String question, String ans, int index) {
    // return Padding(
    //   padding: const EdgeInsets.only(bottom: 10),
    //   child: StreamBuilder<bool>(
    //       stream: consumerHome.getFaqToggle,
    //       builder: (context, snapshot) {
    //         return Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 Expanded(
    //                     child: Text(
    //                   question,
    //                   style: TextStyle(
    //                       fontSize: 14,
    //                       fontWeight: FontWeight.w500,
    //                       color: DefaultColor.blackSubText),
    //                 )),
    //                 IconButton(
    //                     onPressed: () {
    //                       if (snapshot.data!) {
    //                         consumerHome.updateFaqToggle.add(snapshot.data![index]);
    //                       } else {
    //                         consumerHome.updateFaqToggle.add(true);
    //                       }
    //                     },
    //                     icon: Icon(snapshot.data!
    //                         ? Icons.keyboard_arrow_down
    //                         : Icons.keyboard_arrow_up))
    //               ],
    //             ),
    //             snapshot.data!
    //                 ? Text(
    //                     ans,
    //                     style: TextStyle(
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.w400,
    //                         color: DefaultColor.blackSubText),
    //                   )
    //                 : Container()
    //           ],
    //         );
    //       }),
    // );
    return ExpandablePanel(
      header: Text(question, style: TextStyle(fontWeight: FontWeight.bold),),
      collapsed: Container(
        height: 0,
        width: 0,
      ),
      expanded: Text(
        ans,
        softWrap: true,
      ),
      theme: ExpandableThemeData(
          hasIcon: true,
          tapHeaderToExpand: true,
          alignment: Alignment.topRight,
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          iconPlacement: ExpandablePanelIconPlacement.right),
    );
  }

  @override
  Widget build(BuildContext context) {
    consumerHome.getFaqData();
    return Scaffold(
      backgroundColor: DefaultColor.scaffoldBgWhite,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(bottom: 20),
        child: CommonCustomBG(
          cardTopPadding: 7.5,
          widgetsOverGradient: AppBarBackArrow(
              title: "FAQ’s", onTap: () => Navigator.pop(context)),
          widgetOverCard: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FAQ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: DefaultColor.black),
                ),

                StreamBuilder<FaqRes>(
                    stream: consumerHome.getFaqRseStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return faqUI(
                              snapshot.data?.data?[index].title ??
                                  "What is the time taken for approval?",
                              snapshot.data?.data?[index].description ?? "ans",
                              index);
                        },
                        itemCount: snapshot.data?.data?.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      );
                    }),
                // faqUI("How to apply for No-cost EMI?",
                //     "To apply for no-cost EMI, give a miss call on 25410369870 or visit this link www.gmoney.loans/register"),
                // faqUI("What is the time taken for approval?", "ans"),
                // faqUI("How many EMI's will i get?", "ans"),
                // faqUI("What is the EMI duration?", "ans"),
                // faqUI("What benefits i get on silver card?", "ans"),
                // faqUI("how to upgrade my card", "ans")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
