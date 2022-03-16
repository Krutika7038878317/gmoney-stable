import "package:flutter/material.dart";
import 'package:gmoney/ui/auth/change_mPin.dart';
import 'package:gmoney/ui/dashboard_components/completeKyc/aadhaar_details.dart';
import 'package:gmoney/ui/dashboard_components/completeKyc/updated_agreement.dart';
import 'package:gmoney/ui/pages/home_screen.dart';
import 'package:gmoney/main.dart';
import 'package:gmoney/ui/auth/login_screen.dart';
import 'package:gmoney/ui/auth/mpin_auth.dart';
import 'package:gmoney/ui/auth/mpin_screen.dart';
import 'package:gmoney/ui/dashboard_components/completeKyc/aadhaar_details.dart';
import 'package:gmoney/ui/dashboard_components/completeKyc/bank_details.dart';
import 'package:gmoney/ui/dashboard_components/completeKyc/e_mandate.dart';
import 'package:gmoney/ui/pages/home_screen.dart';
import 'package:gmoney/ui/pages/my_emi.dart';
import 'package:gmoney/ui/permissions_screen.dart';
import 'package:gmoney/ui/splash.dart';
import 'package:gmoney/ui/walkthrough_screens.dart';

import '../ui/TakePictureScreen.dart';
import '../ui/dashboard_components/completeKyc/agreemenet_kyc.dart';
import '../ui/dashboard_components/completeKyc/kyc_complete.dart';
import '../ui/dashboard_components/terms_screen.dart';
import '../ui/dashboard_components/drawer_widgets/faq_screen.dart';
import '../ui/pages/my_bills/my_bills_details.dart';
import '../ui/pages/my_bills/my_bills_otp.dart';
import '../ui/pages/my_bills/my_bills_screen.dart';
import '../ui/widgets/home/navigation_drawer.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/HomeScreen':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/Splash':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/TakePictureScreen':
        return MaterialPageRoute(
            builder: (_) => TakePictureScreen(
                  // camera: cameras.last,
                  camera: cameras.last,
                ));

      case '/NavigationDrawer':
        return MaterialPageRoute(builder: (_) => NavigationDrawer());
      case '/TutorialScreens':
        return MaterialPageRoute(builder: (_) => TutorialScreen());
      case '/PermissionsScreen':
        return MaterialPageRoute(builder: (_) => PermissionsScreen());
      case '/LoginScreen':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/CreateMPinScreen':
        return MaterialPageRoute(builder: (_) => NewMPin());
      case '/MyEMIsScreen':
        return MaterialPageRoute(builder: (_) => MyEMIs());
      case '/EMandate':
        return MaterialPageRoute(builder: (_) => EMandate());
      case '/BankDetailsScreen':
        return MaterialPageRoute(builder: (_) => BankDetailsScreen());
      case '/PinAuthScreen':
        return MaterialPageRoute(builder: (_) => PinAuth());
      case '/AgreementScreen':
        return MaterialPageRoute(builder: (_) => AgreementScreen());
      case '/AgreementUrlScreen':
        return MaterialPageRoute(builder: (_) => NewAgreement());
      case '/ChangePinScreen':
        return MaterialPageRoute(builder: (_) => ChangeMPin());
      case '/AadhaarDetails':
        return MaterialPageRoute(builder: (_) => AadhaarDetails());
      case '/FAQScreen':
        return MaterialPageRoute(builder: (_) => FAQScreen());
      case '/MyBillsScreen':
        return MaterialPageRoute(builder: (_) => MyBillsScreen());
      case '/MyBillsDetails':
        final data = settings.arguments;
        return MaterialPageRoute(builder: (_) => MyBillsDetails(index: data,));
      case '/MyBillsOtp':
        return MaterialPageRoute(builder: (_) => MyBillsOtp());
      case '/TermsScreen':
        return MaterialPageRoute(builder: (_) => TermsScreen());
      case '/KycCompleteScreen':
        return MaterialPageRoute(builder: (_) => KycCompleteScreen());
      default:
        return MaterialPageRoute(builder: (_) => Splash());
    }
  }
}
