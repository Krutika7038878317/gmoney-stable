import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gmoney/bloc/consumer_home.dart';
import 'package:gmoney/models/consumer_home_model.dart';
import 'package:gmoney/models/consumer_model.dart';
import 'package:gmoney/ui/dashboard_components/terms_screen.dart';
import 'package:gmoney/ui/pages/home_screen.dart';
import 'package:gmoney/ui/pages/my_emi.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/utils.dart';
import '../../auth/change_mPin.dart';

class NavigationDrawer extends StatefulWidget {
  // widget._homeScreenController = Get.put(MConsumerController());
  //MConsumerController? _homeScreenController;
  NavigationDrawer();

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String? currentDate;
  String? firstNameStr;

  @override
  void initState() {
    super.initState();
    var now = new DateTime.now();
    //currentDate = (now.day.toString());
    var formatter = DateFormat('d MMM y');
    currentDate = formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: StreamBuilder<ConsumerHomeModel>(
          stream: consumerHome.homeData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(child: CircularProgressIndicator()));
            }
            var _data = snapshot.data!.data!.customer!;
            return ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [DefaultColor.blueDark, DefaultColor.blueLightGradient],
                      ),
                      borderRadius:
                          BorderRadius.only(topRight: (Radius.circular(20)))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        height: 60,
                        width: 60,
                        child: snapshot
                                .data!.data!.cards![0].selfie!.link!.isEmpty
                            ? ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: Image.asset(
                                  'assets/images/profileAvatar.png',
                                ),
                              )
                            : ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: Image.network(
                                  snapshot.data!.data!.cards![0].selfie!.link!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _data.identity!.name ?? "John Wick",
                              style: TextStyle(
                                  color: DefaultColor.appBarWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "CIBIL Score: ${_data.creditScore!.score!}",
                              style: TextStyle(
                                  color: DefaultColor.appBarWhite,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "as of ${currentDate}",
                              style: TextStyle(
                                  color: DefaultColor.appBarWhite,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: (Radius.circular(20)))),
                  child: Column(
                    children: [
                      createDrawerBodyItem(
                        icon: 'assets/images/noun-bill.png',
                        text: ' My Bills',
                        onTap: () => {
                          //IsYourPolicyStrong
                          Navigator.pop(context),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomeScreen())),
                        },
                      ),
                      createDrawerBodyItem(
                        icon: 'assets/images/noun-card.png',
                        text: 'My EMIs',
                        onTap: () => {
                          Navigator.pop(context),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyEMIs())),
                        },
                      ),
                      createDrawerBodyItem(
                        icon: 'assets/images/noun-bank.png',
                        text: 'Bank Details',
                        onTap: () => {
                          //ContactUsScreen
                          Navigator.pop(context),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomeScreen())),
                        },
                      ),
                      createDrawerBodyItem(
                        icon: 'assets/images/noun-document.png',
                        text: 'Your policy',
                        onTap: () => {
                          Navigator.pop(context),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomeScreen())),
                        },
                      ),
                      createDrawerBodyItem(
                        icon: 'assets/images/noun-pin-code.png',
                        text: 'Change mPin',
                        onTap: () => {
                          Navigator.pop(context),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChangeMPin())),
                        },
                      ),
                      createDrawerBodyItem(
                        icon: 'assets/images/noun-pin-code.png',
                        text: 'Biometric Auth',
                        onTap: () => {
                          Navigator.pop(context),
                        },
                      ),
                      createDrawerBodyItem(
                        icon: 'assets/images/noun-faq.png',
                        text: 'FAQs',
                        onTap: () => {
                          Navigator.pushNamed(context, "/FAQScreen")
                        },
                      ),
                      createDrawerBodyItem(
                        icon: 'assets/images/noun-document.png',
                        text: 'Terms and conditions',
                        onTap: () => {
                          Navigator.pop(context),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TermsScreen())),
                        },
                      ),
                      createDrawerBodyItem(
                        icon: 'assets/images/noun-about-us.png',
                        text: 'Contact us',
                        onTap: () => {
                          showAlertDialog(context),
                          // clearSessionOnLogout(context),
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

Future<void> showAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: SingleChildScrollView(
          child: Text(
            'Are you sure want to logout',
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: Text('Ok'),
              onPressed: () {
                clearSessionOnLogout(context);
              }
              //Navigator.of(context).pop(),
              ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    },
  );
}

void clearSessionOnLogout(BuildContext context) async {
  final pref = await SharedPreferences.getInstance();
  await pref.clear();
  //Get.offAll(AppPages.WELCOMESCREEN);
  //Get.off(MobileScreen());

  // Get.offAll(MobileScreen());

  Navigator.pushAndRemoveUntil<dynamic>(
    context,
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => HomeScreen(),
    ),
    (route) => false, //if you want to disable back feature set to false
  );

  /* Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(builder: (context) => StartPaginationScreen()));*/
}

Widget createDrawerHeader(ConsumerModel consumerModel, String currentDate,
    String firstNameStr, BuildContext context) {
  String imgStr = consumerModel.data?.customer?.identity?.name ?? "A";

  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    },
    child: Container(
      height: 250.0,
      child: DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 80,
                  width: 80,
                  child: (consumerModel.data?.cards?[0].selfie?.link != "")
                      ? CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              "https://picsum.photos/seed/picsum/200/300"),
                          /*NetworkImage(
                            consumerModel.data?.cards?[0].selfie?.link ??
                                "https://picsum.photos/seed/picsum/200/300"),*/
                          backgroundColor: Colors.transparent,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            color: Colors.blue,
                            height: 80,
                            width: 80,
                            child: Center(
                              child: Text(
                                imgStr[0],
                                style: TextStyle(
                                    color: Colors.white, //Colors.blue,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
              Container(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      consumerModel.data?.customer?.identity?.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'ProductSansRegular',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    /*Text(
                      consumerModel.data?.customer?.mobile.toString() ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'ProductSansRegular',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),*/
                    Text(
                      "CIBIL Scrore : "
                      "${consumerModel.data?.customer?.creditScore?.score ?? ""}",
                      //consumerModel.data?.customer?.toString() ?? "", //Need to change
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'ProductSansRegular',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "as on " "${currentDate}",
                      //consumerModel.data?.customer?.toString() ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'ProductSansRegular',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.all(0.0),
          padding: EdgeInsets.all(0.0)),
    ),
  ); /*DrawerHeader(
    
    
    margin: EdgeInsets.only(top: 10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 80,
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
                consumerModel.data?.cards?[0].selfie?.link ??
                    "https://picsum.photos/seed/picsum/200/300"),
            backgroundColor: Colors.transparent,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                consumerModel.data?.customer?.identity?.name ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'ProductSansRegular',
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                consumerModel.data?.customer?.mobile.toString() ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'ProductSansRegular',
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "CBL Score", //consumerModel.data?.customer?.toString() ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'ProductSansRegular',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );*/
}

Widget createDrawerBodyItem(
    {String? icon, String? text, GestureTapCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        height: 25,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(icon!, color: Color(0xff014078)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                text ?? "",
                style: TextStyle(
                    fontSize: 18,
                    // fontWeight: FontWeight.bold,
                    fontFamily: 'ProductSansRegular',
                    color: Color(0xff373737)),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
