import 'package:flutter/material.dart';
import 'package:gmoney/data/data.dart';

import '../util/user_data.dart';
import '../util/utils.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => new _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {

  // List<SliderModel> mySlides = new List<SliderModel>();
  List<SliderModel> mySlides = <SliderModel>[];
  int slideIndex = 0;
  late PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: isCurrentPage ? 8.0 : 8.0,
      width: isCurrentPage ? 8.0 : 8.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? DefaultColor.lightGrey : DefaultColor.lightGrey,
          gradient: isCurrentPage?new LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [DefaultColor.blueDark, DefaultColor.blueLightGradient],
          ):new LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [DefaultColor.lightGrey, DefaultColor.lightGrey],
          ),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySlides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Column(
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: PageView(
                        controller: controller,
                        onPageChanged: (index) {
                          setState(() {
                            slideIndex = index;
                          });
                        },
                        children: <Widget>[
                          SlideTile(
                            imagePath: mySlides[0].getImageAssetPath()!,
                            title: mySlides[0].getTitle()!,
                            desc: mySlides[0].getDesc()!,
                            tutorialTitle: mySlides[0].getTutorialTitle()!,
                            header: mySlides[0].getHeader()!,
                          ),
                          SlideTile(
                            imagePath: mySlides[1].getImageAssetPath()!,
                            title: mySlides[1].getTitle()!,
                            desc: mySlides[1].getDesc()!,
                            tutorialTitle: mySlides[1].getTutorialTitle()!,
                            header: mySlides[1].getHeader()!,
                          ),
                          SlideTile(
                            imagePath: mySlides[2].getImageAssetPath()!,
                            title: mySlides[2].getTitle()!,
                            desc: mySlides[2].getDesc()!,
                            tutorialTitle: mySlides[2].getTutorialTitle()!,
                            header: mySlides[2].getHeader()!,
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          for (int i = 0; i < 3; i++)
                            i == slideIndex
                                ? _buildPageIndicator(true)
                                : _buildPageIndicator(false),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    child: Text(
                                      "Skip",
                                      style: TextStyle(
                                          color: Color(0xff014078),
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    onTap: () async {
                                     /* Map<Permission, PermissionStatus> statuses = await [
                                      Permission.contacts,
                                          Permission.location,
                                      Permission.camera,
                                      Permission.sms,
                                      ].request();
                                      if (statuses[Permission.contacts] == PermissionStatus.granted &&
                                          statuses[Permission.location] == PermissionStatus.granted &&
                                          statuses[Permission.camera] == PermissionStatus.granted &&
                                          statuses[Permission.sms] == PermissionStatus.granted) {
                                        Navigator.of(context).pushNamedAndRemoveUntil(
                                            '/LoginScreen', (Route<dynamic> route) => false);
                                      }
                                      else*/ Navigator.of(context).pushNamedAndRemoveUntil(
                                          '/PermissionsScreen', (Route<dynamic> route) => false);

                                      // Navigator.of(context).pushReplacementNamed('/SignUpScreen');
                                    },
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Material(
                                color: Color(0xff014078),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: InkWell(
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                          color: DefaultColor.appBarWhite, fontSize: 18),
                                    ),
                                    onTap: () async {
                                      if (slideIndex == 2)
                                        {
                                    /*      Map<Permission, PermissionStatus> statuses = await [
                                          Permission.contacts,
                                              Permission.location,
                                      Permission.camera,
                                      Permission.sms,
                                      ].request();
                                      if (statuses[Permission.contacts] == PermissionStatus.granted &&
                                      statuses[Permission.location] == PermissionStatus.granted &&
                                      statuses[Permission.camera] == PermissionStatus.granted &&
                                      statuses[Permission.sms] == PermissionStatus.granted) {
                                      Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/LoginScreen', (Route<dynamic> route) => false);
                                      }
                                      else*/ Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/PermissionsScreen', (Route<dynamic> route) => false);
                                        }
                                      else
                                        controller.animateToPage(slideIndex + 1,
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.linear);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  String imagePath, title, desc, tutorialTitle, header;

  SlideTile(
      {required this.imagePath,
      required this.title,
      required this.desc,
      required this.tutorialTitle,
      required this.header});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xff014078)),
            ),
          ),
        ],
      ),
    );
  }
}
