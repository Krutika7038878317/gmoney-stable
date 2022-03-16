import 'dart:ui';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:gmoney/bloc/consumer_home.dart';
import 'package:gmoney/models/consumer_home_model.dart';
import 'package:gmoney/ui/widgets/CommonCustomBg.dart';
import 'package:gmoney/ui/widgets/app_button.dart';
import 'package:gmoney/ui/widgets/home/navigation_drawer.dart';
import 'package:gmoney/ui/widgets/home/step_indicator.dart';
import 'package:gmoney/ui/widgets/my_bill_widgets/bottom_sheet_bills.dart';
import 'package:gmoney/util/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final globalKey = GlobalKey<ScaffoldState>();

  bool _isBankUploaded = false;
  bool _isMandateUploaded = false;
  bool _isSelfieUploaded = false;
  bool _isAadhaarUploaded = false;
  bool _isAgreementUploaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    consumerHome.getConsumerHomeData();
  }

/*  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    print("didUpdateWidget");

    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    print("deactivate");
    super.deactivate();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }*/

  Widget _columnKycSteps(String text, String img) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(img),
        SizedBox(
          height: 12,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w500,
              color: Utils.getColorFromHex("#373737")),
        )
      ],
    );
  }

  Widget _title(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Utils.getColorFromHex("#373737")),
      ),
    );
  }

  Widget kycWidget(BuildContext context, Data data) {
    List<CardActiveChecks> _data = data.cards![0].cardActiveChecks!;
    _isBankUploaded = _data.first.uploaded!;
    _isMandateUploaded = _data[1].uploaded!;
    _isSelfieUploaded = _data[2].uploaded!;
    _isAadhaarUploaded = _data[3].uploaded!;
    _isAgreementUploaded = _data[4].uploaded!;
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Utils.getColorFromHex("#FFFFFF"),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Congratulations! You are eligible for the line of credit upto ₹10,00,000 ",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: DefaultColor.appDarkBlue),
          ), //StepIndicator(key, 5,pageController),
          StepIndicator(widget.key, 5, consumerHome.getCount(_data)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    if(!_isBankUploaded)
                    Navigator.pushNamed(context, "/BankDetailsScreen");
                    },
                  child: _columnKycSteps(
                      "Bank Profile", "assets/images/bank_profile.png")),
              GestureDetector(
                  onTap: () {
                    if (_data[0].uploaded! && _data[0].verified! && !_isMandateUploaded) {
                      Navigator.pushNamed(context, "/EMandate");
                    }
                  },
                  child: _columnKycSteps(
                      "e-Nach NPCI", "assets/images/eNach.png")),
              GestureDetector(
                  onTap: () {
                    if(!_isSelfieUploaded)
    Navigator.pushNamed(context, "/TakePictureScreen");
    }
                      ,
                  child: _columnKycSteps("Selfie", "assets/images/selfie.png")),
              GestureDetector(
                  onTap: () {
                    if(!_isAadhaarUploaded)
    Navigator.pushNamed(context, "/AadhaarDetails");
    } ,
                  child:
                      _columnKycSteps("Aadhaar", "assets/images/aadhar.png")),
              GestureDetector(
                //  onTap: () => Navigator.pushNamed(context, "/AgreementScreen"),
                  onTap: () {
                    if(!_isAgreementUploaded)
                    Navigator.pushNamed(context, "/AgreementUrlScreen");
                  },
                  child: _columnKycSteps(
                      "Agreement", "assets/images/agreement.png")),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          AppButton(
            onTap: () {},
            buttonTitle: "Activate Now",
            buttonColour: DefaultColor.appDarkBlue,
          )
        ],
      ),
    );
  }

  Widget _creditLimits() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Utils.getColorFromHex("#FFFFFF"),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "No-cost EMI",
            style: TextStyle(
                color: DefaultColor.appDarkBlue,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Available Bal."), Text("Total Credit")],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: LinearProgressIndicator(
              backgroundColor: Color(0xFFE7E7E7),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              value: 0.8,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("₹2,00,000"), Text("₹3,00,000")],
          )
        ],
      ),
    );
  }

  Widget _mediclaimApproval() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: DefaultColor.appBarWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepIndicator(widget.key, 3, -1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _columnKycSteps(
                  "Upload Policy", "assets/images/upload_policy.png"),
              _columnKycSteps("Upload Consultation Paper",
                  "assets/images/upload_papers.png"),
              _columnKycSteps("Enter Amount", "assets/images/rupees.png"),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          AppButton(
            onTap: () {},
            buttonTitle: "Get Approval",
          )
        ],
      ),
    );
  }

  Widget bottomBarTabsColumn(var icon, String text, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null
              ? Icon(
                  icon,
                  color: HomePageColors.textGrey,
                )
              : Container(
                  height: 20,
                ),
          Text(
            text,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: HomePageColors.textGrey),
          )
        ],
      ),
    );
  }

  saveIdInPrefs(String? id) async {
    var prefs=await SharedPreferences.getInstance();
    prefs.setString("cardId", id!);

  }

  @override
  Widget build(BuildContext context) {
    print("body");
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: globalKey,
      drawer: NavigationDrawer(),
      bottomNavigationBar: ConvexAppBar(
        color: DefaultColor.blueDark,
        backgroundColor: Colors.white,
        activeColor: DefaultColor.blueDark,
        style: TabStyle.fixedCircle,
        cornerRadius: 10,
        items: [
          TabItem(icon: Icons.menu, title: 'Menu'),
          TabItem(icon: Icons.my_library_books, title: 'My Bills'),
          TabItem(icon: Icons.add, title: 'Pay'),
          TabItem(icon: Icons.message, title: 'Near Me'),
          TabItem(icon: Icons.people, title: 'Search'),
        ],
        initialActiveIndex: 2,
        //optional, default as 0
        onTap: (int i) {
          switch(i){
            case 0:
              globalKey.currentState!.openDrawer();
              break;
          }
          switch(i){
            case 2:
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context, builder: (_){
                return BottomSheetBills();
              });
              break;
          }
        },
      ),

      backgroundColor: Utils.getColorFromHex("#E5E5E5"),
      body: SingleChildScrollView(
        child: StreamBuilder<ConsumerHomeModel>(
            stream: consumerHome.homeData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Utils.instance.loader(context);
              }
             saveIdInPrefs(snapshot.data?.data?.cards![0].sId);
              return CommonCustomBG(
                  widgetOverCard: Container(
                    height: 220,
                    width: double.infinity,
                    child:
/*
                CachedNetworkImage(
                  imageUrl:
                  "http://b2c-bucket-model-uat.s3.ap-south-1.amazonaws.com/Lender_Cards/Harvinder_Finance/GoldElite.jpg",
                  placeholder: (context, url) => Container(
                      height: 32,
                      width: 32,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) {
                    print('image error');
                    print(error);
                    return Icon(Icons.error);
                  },
                ),
*/
                        Container(
                      padding: EdgeInsets.only(top: 38),
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(snapshot
                                  .data!.data!.cards![0].type!.cardImage!))),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data!.data!.cards![0].cardNumber ?? "",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1C4892)),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            snapshot.data!.data!.customer!.identity!.name ??
                                "John Wick",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1C4892)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  screenWidgets: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title("Complete your KYC"),
                      kycWidget(context,
                          snapshot.data!.data!),
                      _title("Pre approved credit limits"),
                      _creditLimits(),
                      _title("Advance against mediclaim approval"),
                      _mediclaimApproval(),
                    ],
                  ),
                  widgetsOverGradient:
                      topGradientUI(_height, snapshot.data!.data!.customer!));
            }),
      ),
    );
  }
}

Widget topGradientUI(var _height, Customer data) {
  return Padding(
    padding: EdgeInsets.fromLTRB(15, _height * 0.06, 10, 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good morning,",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                data.identity!.name!.split(" ").first,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications,
            color: Utils.getColorFromHex("#DADADA"),
          ),
          iconSize: 28,
        )
      ],
    ),
  );
}
