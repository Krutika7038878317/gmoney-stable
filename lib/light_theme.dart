// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmoney/util/utils.dart';

ThemeData prAppThemeLight() {
  /// colors provided for app
  Color mainBarColor = Colors.white;
  Color buttonsColor = Color(0xFF2BB5F4);
  Color hintIconsColor = Color(0xFFA9A9A9);
  // Color hintIconsColor = Color(0xFFA9A9A9);
  Color subTextColor = Color(0xFF666666);
  Color errorColor = Color(0xFFFF1F00);
  Color menuHeadingsColor = Color(0xFF000000);
  // Color toastColor = Color(0xFF515151);
  // Color statusOpenColor = Color(0xFF8E8E8E);
  // Color statusCloseColor = Color(0xFFFFA66B);
  // Color statusFinishColor = Color(0xFF4FD96B);
  // others refer to utility file

  return ThemeData(
      brightness: Brightness.light,
      visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
      // primarySwatch: Colors.blueGrey,
      primarySwatch: MaterialColor(
        0xFFA54032,
        <int, Color>{
          50: mainBarColor,
          100: mainBarColor,
          200: mainBarColor,
          300: mainBarColor,
          400: mainBarColor,
          500: mainBarColor,
          600: mainBarColor,
          700: mainBarColor,
          800: mainBarColor,
          900: mainBarColor
        },
      ),
      primaryColor: mainBarColor,
      primaryColorBrightness: Brightness.light,
      primaryColorLight: mainBarColor,
      primaryColorDark: buttonsColor,
      canvasColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      bottomAppBarColor: Colors.white,
      cardColor: Colors.white,
      dividerColor: mainBarColor,
      focusColor: mainBarColor,
      hoverColor: mainBarColor,
      highlightColor: mainBarColor.withOpacity(0.5),
      splashColor: mainBarColor.withOpacity(0.5),
//  splashFactory: # override create method from  InteractiveInkFeatureFactory
      selectedRowColor: Colors.grey,
      unselectedWidgetColor: Colors.grey.shade400,
      disabledColor: Colors.grey.shade200,
      secondaryHeaderColor: mainBarColor,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Color(0xffB5BFD3),
        cursorColor: Color(0xff936F3E),
        selectionHandleColor: Color(0xff936F3E),
      ),
      dialogBackgroundColor: Colors.white,
      hintColor: hintIconsColor,
      errorColor: errorColor,
      shadowColor: menuHeadingsColor,

      /// updated themes begin

      appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 2,
          iconTheme: IconThemeData(
            color: DefaultColor.lightGrey,
          ),
          backgroundColor: mainBarColor,
          actionsIconTheme: IconThemeData(color: DefaultColor.underlineGrey, size: 24),
          titleTextStyle: TextStyle(
            color: DefaultColor.appLightBlue,
            fontSize: 32,
            fontFamily: 'DaxCondensed',
          ),
          toolbarTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'DaxCondensed',
          ),
          shadowColor: Colors.black),
      textTheme: TextTheme(
        button: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'PTSansNarrow'),
        bodyText1: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'PTSansNarrow'),
        bodyText2: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'PTSansNarrow'),
        headline1: TextStyle(color: Colors.white, fontSize: 32, fontFamily: 'DaxCondensed'),
        headline2: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'DaxCondensed'),
        headline3: TextStyle(color: menuHeadingsColor, fontSize: 26, fontFamily: 'DaxCondensed'),
        headline4: TextStyle(color: menuHeadingsColor, fontSize: 24, fontFamily: 'DaxCondensed'),
        headline5: TextStyle(color: menuHeadingsColor, fontSize: 20, fontFamily: 'DaxCondensed'),
        headline6: TextStyle(color: menuHeadingsColor, fontSize: 18, fontFamily: 'DaxCondensed'),
        subtitle1: TextStyle(color: subTextColor, fontSize: 20, fontFamily: 'DaxCondensed'),
        subtitle2: TextStyle(color: subTextColor, fontSize: 18, fontFamily: 'DaxCondensed'),
        caption: TextStyle(color: Colors.white, fontSize: 10),
      ),
      //alternate text theme
      primaryTextTheme: TextTheme(
        button: TextStyle(color: mainBarColor, fontSize: 16, fontFamily: 'PTSansNarrow'),
        bodyText1: TextStyle(color: buttonsColor, fontSize: 18, fontFamily: 'PTSansNarrow'),
        bodyText2: TextStyle(color: buttonsColor, fontSize: 16, fontFamily: 'PTSansNarrow'),
        headline1: TextStyle(color: mainBarColor, fontSize: 32, fontFamily: 'DaxCondensed'),
        headline2: TextStyle(color: mainBarColor, fontSize: 30, fontFamily: 'DaxCondensed'),
        headline3: TextStyle(color: mainBarColor, fontSize: 26, fontFamily: 'DaxCondensed'),
        headline4: TextStyle(color: mainBarColor, fontSize: 24, fontFamily: 'DaxCondensed'),
        headline5: TextStyle(color: mainBarColor, fontSize: 20, fontFamily: 'DaxCondensed'),
        headline6: TextStyle(color: mainBarColor, fontSize: 18, fontFamily: 'DaxCondensed'),
        subtitle1: TextStyle(color: mainBarColor, fontSize: 20, fontFamily: 'DaxCondensed'),
        subtitle2: TextStyle(color: mainBarColor, fontSize: 18, fontFamily: 'DaxCondensed'),
        caption: TextStyle(color: Colors.white),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        textStyle: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontFamily: 'DaxCondensed',
          decorationColor: Colors.red,
        ),
      )),
      inputDecorationTheme: InputDecorationTheme(
          // default values for InputDecorator, TextField, and TextFormField
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 5,
          ),
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'DaxCondensed',
          ),
          hintStyle: TextStyle(
            color: hintIconsColor,
            fontSize: 22,
            fontFamily: 'DaxCondensed',
          )),
      cardTheme: CardTheme(
        margin: EdgeInsets.all(0),
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shadowColor: Colors.black,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), side: BorderSide(color: hintIconsColor, width: 1)),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.zero,
          side: BorderSide(color: hintIconsColor, width: 1),
          backgroundColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8),
          onPrimary: Colors.white,
          primary: buttonsColor,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'DaxCondensed',
            // letterSpacing: 2.0
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        size: 25,
        color: mainBarColor,
        //icon themes that contrast with card and canvas
      ),
      primaryIconTheme: IconThemeData(size: 25, color: Colors.white
          //icon themes that contrast primary color
          ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.white,
        // shape: RoundedRectangleBorder(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),

      /// updated themes end

      colorScheme: ColorScheme(
          primary: mainBarColor,
          primaryVariant: Color(0x1aF5E0C3),
          secondary: mainBarColor,
          secondaryVariant: Color(0xaaC9A87C),
          brightness: Brightness.light,
          background: Colors.white,
          error: Colors.red,
          onBackground: Colors.white,
          onError: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Color(0xffC9A87C),
          onSurface: mainBarColor,
          surface: Colors.white),

      /// themes to implement in future
      tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          labelStyle: TextStyle(
            color: menuHeadingsColor,
            fontSize: 24,
            fontFamily: 'DaxCondensed',
          ),
          unselectedLabelStyle: TextStyle(
            color: menuHeadingsColor,
            fontSize: 24,
            fontFamily: 'DaxCondensed',
          )),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      snackBarTheme: SnackBarThemeData(),
      dialogTheme: DialogTheme(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.black,
      ),

      // fontFamily: 'ROBOTO',
      splashFactory: InkSplash.splashFactory);
}
