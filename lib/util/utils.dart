import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Font {
  static const String LIGHT   = 'Cereal Light';
  static const String MEDIUM = 'Cereal Medium';
  static const String BOLD    = 'Cereal Bold';
  static const String EXTRABOLD    = 'Cereal ExtraBold';
  static const String BLACK    = 'Cereal Black';
  static const String BOOK    = 'Cereal Book';
  static const String POPPINS    = 'Poppins Regular';
  static const String POPPINS_SB    = 'Poppins SemiBold';
  static const String POPPINS_B    = 'Poppins Bold';
}

class DefaultColor {
  static const blue = Color(0xFF0263F9);
  static const appPurple = Color(0xFF9013FE);
  static const appLightBlue = Color(0xFF3EA9F5);
  static const appHintLightBlue = Color(0xFFBCE0FD);
  static const appDividerColour = Color(0xFFF5DFDE);
  static const appDarkBlue = Color(0xFF014078);
  static const appUserBlue = Color(0xFF2699FB);
  static const appReplyButtonBlue = Color(0xFF2BB5F4);
  static const orange = Color(0xFFFF741C);
  static const black = Color(0xFF000000);
  static const blueDarkLogin = Color(0xFF111827);
  static const pinTextLogin = Color(0xFF464646);
  static const greenText = Color(0xFF00754A);
  static const redText = Color(0xFFD23428);
  static const scaffoldBgWhite = Color(0xFFDBDBDB);
  static const blueMobile = Color(0xFF014078);
  static const blackTC = Color(0xFF464646);
  static const blackSubText = Color(0xFF373737);
  static const blackButtonText = Color(0xFF595959);
  static const greyButtonColor = Color(0xFFDCDCDC);
  static const grey = Color(0xFF666666);
  static const greyBackButton = Color(0xFF8A8A8F);
  static const greyBackground = Color(0xFFF8F8F8);
  static const greyHomeBackground = Color(0xFFF9F9F9);
  static const lightGrey = Color(0xFFE5E5E5);
  static const greyBanner = Color(0xFFf1f1f1);
  static const green = Color(0xFF00A866);
  static const poppinsGrey = Color(0xFF909090);
  static const darkOrange = Color(0XFFFF741C);
  static const red = Color(0XFFFF0E0E);
  static const redLight = Color(0XFFD23428);
  static const blueDark = Color(0XFF014078);
  static const blueLightGradient = Color(0XFF0261B6);
  static const appRed = Color(0XFFEC1111);
  static const underlineGrey = Color(0XFFEFEFF4);
  static const appBarWhite = Color(0XFFFFFFFF);
  static var linearGradient = LinearGradient(colors: [
  Utils.getColorFromHex("#014078"),Utils.getColorFromHex("#0261B6")], begin: const FractionalOffset(0.0, 0.0),
    end: const FractionalOffset(1.0, 0.5),stops: [0.0, 1.0],);
}
class VerificationColors{
  static const grey = Color(0xFF4A4A4A);
  static const cyan = Color(0xFF2BB5F4);
}
class HomePageColors{
  static const green = Color(0xFF5CB85C);
  static const yellow = Color(0xFFF0AD4E);
  static const darkRed = Color(0xFFD9534F);
  static const darkBlue = Color(0xFF0263F9);
  static const textGrey = Color(0xFF9C9A9A);
}
class AadhaarColors{
  static const viewBtnBorder = Color(0xFFD8D8D8);
  static const textGrey = Color(0xFF373737);
}

class TextStyles {
  static const TextStyle nameHeadings = TextStyle(fontSize: 28, color: DefaultColor.black,fontWeight: FontWeight.w400);
  static const TextStyle lightGrey13 =  TextStyle(fontSize: 13, color: DefaultColor.greyBackButton);
  static const TextStyle blue17 = TextStyle(fontSize: 17.0, color: DefaultColor.appDarkBlue);
  static const TextStyle grey17 = TextStyle(fontSize: 17.0, color: DefaultColor.grey);
  static const TextStyle black40 = TextStyle(fontSize: 40.0, color: DefaultColor.black);
  static const TextStyle black17 = TextStyle(fontSize: 17.0, color: DefaultColor.black);
  static const TextStyle boldOrange = TextStyle(fontFamily: Font.BOLD, color: DefaultColor.orange);
  static const TextStyle boldBlack = TextStyle(fontFamily: Font.BOLD, color: DefaultColor.black);
  static const TextStyle boldWhite = TextStyle(fontFamily: Font.BOLD, color: Colors.white);
  static const TextStyle boldGrey = TextStyle(fontFamily: Font.BOLD, color: DefaultColor.grey);
  static const TextStyle mediumBlack = TextStyle(fontFamily: Font.MEDIUM, color: DefaultColor.black);
  static const TextStyle mediumOrange = TextStyle(fontFamily: Font.MEDIUM, color: DefaultColor.orange);
  static const TextStyle mediumWhite = TextStyle(fontFamily: Font.MEDIUM, color: Colors.white);
  static const TextStyle mediumGrey = TextStyle(fontFamily: Font.MEDIUM, color: DefaultColor.grey);
  static const TextStyle mediumLightGrey = TextStyle(fontFamily: Font.MEDIUM, color: DefaultColor.lightGrey);
  static const TextStyle bookBlack = TextStyle(fontFamily: Font.BOOK, color: DefaultColor.black);
  static const TextStyle bookWhite = TextStyle(fontFamily: Font.BOOK, color: Colors.white);
  static const TextStyle bookGrey = TextStyle(fontFamily: Font.BOOK, color: DefaultColor.grey);
  static const TextStyle bookLightGrey = TextStyle(fontFamily: Font.BOOK, color: DefaultColor.lightGrey);
  static const TextStyle lightBlack = TextStyle(fontFamily: Font.LIGHT, color: DefaultColor.black);
  static const TextStyle lightWhite = TextStyle(fontFamily: Font.LIGHT, color: Colors.white);
  static const TextStyle lightGrey = TextStyle(fontFamily: Font.LIGHT, color: DefaultColor.grey);
  static const TextStyle lightLightGrey = TextStyle(fontFamily: Font.LIGHT, color: DefaultColor.lightGrey);
  static const TextStyle lightOrange = TextStyle(fontFamily: Font.LIGHT, color: DefaultColor.orange);
  static const TextStyle poppinsRegularGrey = TextStyle(fontFamily: Font.POPPINS, color: DefaultColor.poppinsGrey);
  static const TextStyle poppinsRegularBlack = TextStyle(fontFamily: Font.POPPINS, color: DefaultColor.black);
  static const TextStyle poppinsSbBlack = TextStyle(fontFamily: Font.POPPINS_SB, color: DefaultColor.black);
  static const TextStyle poppinsSbGreen = TextStyle(fontFamily: Font.POPPINS_B, color: DefaultColor.green);
}

class Utils {
  static final Utils instance = new Utils.internal();

  Utils.internal();

  factory Utils() {
    return instance;
  }

  final gapContainer = Container();



  Widget notFoundContainer(String text) => Container(
      margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
      height: 270.0,
      child: Center(
        child: Text(
            'No $text found',
            style: TextStyles.mediumLightGrey.copyWith(fontSize: 22.0)
        ),
      )
  );

  Future emailAddressValidator(String email) {
    Completer completer = new Completer();
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    if(email.isEmpty) completer.completeError('An email address should be present');
    else if(!regex.hasMatch(email)) completer.completeError('Excitement has overtaken you! Invalid email address');
    else completer.complete(true);
    return completer.future;
  }



  Future validateFirstLast(String value){
    Completer completer = new Completer();
    Pattern pattern = "^([a-zA-Z]\s[a-zA-Z]'?-?[a-zA-Z]\s?([a-zA-Z])?)";
    RegExp regex = new RegExp(pattern.toString());
    if(value.isEmpty) completer.completeError('First and Last Name cannot be left blank');
    else if(!regex.hasMatch(value)) completer.completeError('Enter first and last name');
    else completer.complete(true);
    return completer.future;
  }

  String? validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    if(!regex.hasMatch(value)) return 'Excitement has overtaken you! Invalid email address';
    else return null;
  }

  Future displayNameValidator(String name) {
    Completer completer = new Completer();
    if (name.length < 3) completer.completeError('Name must be more than 2 charater');
    else if(name.split(" ").length < 2) completer.completeError('Please enter your full name');
    else completer.complete(true);
    return completer.future;
  }

  Future phoneNumberValidator(String selectedCountry, String phoneNumber) {
    Completer completer = new Completer();
    if(phoneNumber.length < 10) completer.completeError('Excitement has overtaken you! Invalid mobile number');
    else completer.complete(true);
    return completer.future;
  }

  Future smsCodeValidator(String code) {
    Completer completer = new Completer();
    if (code.isEmpty || code.length != 6) completer.completeError('Please enter 6-digits code!');
    else completer.complete(true);
    return completer.future;
  }

  delayed(Duration duration, VoidCallback voidCallback) => Timer(duration, voidCallback);

  gotoScreen(BuildContext context, Widget widget) => Navigator.of(context).push(
      MaterialPageRoute(
          builder: (BuildContext context) => widget
      )
  );

  void showToast(String message, {bool isBottom = true}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: isBottom?ToastGravity.BOTTOM : ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: DefaultColor.greyBanner,
        textColor: Colors.black,
        fontSize: 14.0
    );
  }
  static Widget _gridTile(BuildContext context, String title, IconData icon,
      VoidCallback onTap) =>
      GestureDetector(
          onTap: onTap,
          child: GridTile(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                // border: Border.all(color: Colors.grey[300], width: 2.0, style: BorderStyle.solid)
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(icon, size: 40.0, color: Colors.grey[500]),
                  SizedBox(width: 10,),
                  Text(title,
                      style: TextStyles.bookBlack.copyWith(fontSize: 14.0))
                ],
              ),
            ),
          ));
  static Future<void> imageSelectorDialogBox(BuildContext context,
      GestureTapCallback picture, GestureTapCallback video) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: new SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: new ListBody(
                      children: <Widget>[
                        _gridTile(context, 'Camera', Icons.camera_alt,
                            picture),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                        ),
                        _gridTile(context, 'Gallery',
                            Icons.perm_media_rounded, video)
                      ],
                    ),
                  ),
                  Positioned(
                    child: GestureDetector(
                      child: Icon(
                        Icons.clear_sharp,
                        color: DefaultColor.grey,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    right: 2,
                    top: 2,
                  ),
                ],
              ),
            ),
          );
        });
  }
  static String getTimeAgo(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    print(time);
    print("time");

    return time;
  }
  Widget loader(BuildContext context){
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(child: CircularProgressIndicator()));
  }
  String dateFormation(String date){
    var formatter = DateFormat('d MMM y');
    String _date = formatter.format(DateTime.parse(date));
    return _date;
  }


  ///check internet connection
  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
  ///show error message
  static void showErrorMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  ///show normal message
  static void showNormalMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  ///show normal message
  static void showSuccessMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Utils.getColorFromHex("#00800B"),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  ///show normal in center message
  static void showSuccessMessageCenter(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Utils.getColorFromHex("#00800B"),
        textColor: Colors.white,
        fontSize: 16.0);
  }
  /// converts HEX to RGB Color
  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }
  bool emailReg(email){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
return emailValid;
  }


  /// space at top of the UI
  Widget screenTopSpace(BuildContext context){
    return SizedBox(height: MediaQuery.of(context).size.height*0.01,);
  }
  }


class AlertMessagesUtils {
  static Widget alertDialogIOS(String title, String content, List<Widget> actions) => CupertinoAlertDialog(
    title: Text(title),
    content: Text(content),
    actions: actions,
  );

  static Widget alertDialogAndroid(String title, String content, List<Widget> actions) => AlertDialog(
    title: Text(title, style: TextStyle(fontFamily: 'Lintel Bold', fontSize: 16.0),),
    content: Text(content, style: TextStyle(fontFamily: 'Lintel Medium', fontSize: 14.0),),
    actions: actions,
  );
}
