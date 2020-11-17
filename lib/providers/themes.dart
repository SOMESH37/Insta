import '../helper.dart';

class MyTheme extends ChangeNotifier {
  static ThemeData myLight = ThemeData.light().copyWith(
    chipTheme: ChipThemeData(
      brightness: Brightness.light,
      labelStyle: TextStyle(
        color: Colors.black,
        fontFamily: 'Gilroy',
        letterSpacing: 0.4,
      ),
      secondaryLabelStyle: TextStyle(
        color: Color(0xff1477f8),
        fontFamily: 'Gilroy',
        letterSpacing: 0.4,
      ),
      backgroundColor: Colors.white,
      disabledColor: Colors.grey,
      selectedColor: Colors.red, // waste yet @required
      secondarySelectedColor: Colors.white,
      padding: EdgeInsets.all(10),
      shape: StadiumBorder(),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.grey[500],
      ),
      color: Colors.transparent,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(
        color: Color(0xff1477f8),
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.white,
        ),
        enableFeedback: false,
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.grey[600],
        ),
        // elevation: MaterialStateProperty.resolveWith((states) => 2),
        minimumSize: MaterialStateProperty.resolveWith(
          (states) => Size(double.infinity, 60),
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 20,
            fontFamily: 'Gilroy',
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.white,
        ),
        elevation: MaterialStateProperty.resolveWith(
          (states) => 0,
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.grey[600],
        ),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) => Colors.grey[200],
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) => TextStyle(
            color: Colors.grey[500],
            fontFamily: 'Gilroy',
          ),
        ),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        side: MaterialStateProperty.resolveWith(
          (states) => BorderSide(color: Colors.grey[300]),
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      height: 60,
      minWidth: double.infinity,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      buttonColor: Color(0xff1477f8),
    ),
    dividerTheme: DividerThemeData(
      thickness: 2,
    ),
    scaffoldBackgroundColor: Color(0xfff3f7fd), //(0xfff3f7f8)
    textTheme: TextTheme(
      // default text, textField text
      bodyText2: TextStyle(
        color: Colors.black,
        fontFamily: 'Gilroy',
        letterSpacing: 0.4,
      ),
      // for info
      subtitle1: TextStyle(
        color: Colors.grey[500],
        fontFamily: 'Gilroy',
      ),
      // for @mentions
      subtitle2: TextStyle(
        color: Colors.blue[800],
        fontSize: 16,
        fontFamily: 'Gilroy',
      ),
      // for welcome text
      headline6: TextStyle(
        color: Colors.grey[500],
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Gilroy',
      ),
      // for textFieldHeading text
      headline5: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'Gilroy',
      ),
      headline4: TextStyle(
        color: Colors.grey[700],
        fontSize: 22,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
        letterSpacing: 0.6,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.all(21),
    ),
  );
  static ThemeData myDark = ThemeData.dark().copyWith(
    chipTheme: ChipThemeData(
      brightness: Brightness.light,
      labelStyle: TextStyle(
        color: Colors.black,
        fontFamily: 'Gilroy',
        letterSpacing: 0.4,
      ),
      secondaryLabelStyle: TextStyle(
        color: Color(0xff1477f8),
        fontFamily: 'Gilroy',
        letterSpacing: 0.4,
      ),
      backgroundColor: Colors.white,
      disabledColor: Colors.grey,
      selectedColor: Colors.red, // waste yet @required
      secondarySelectedColor: Colors.white,
      padding: EdgeInsets.all(10),
      shape: StadiumBorder(),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.grey[500],
      ),
      color: Colors.transparent,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff1f2930),
      selectedIconTheme: IconThemeData(
        color: Color(0xff1477f8),
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => Color(0xff1f2930),
        ),
        enableFeedback: false,
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.grey[500],
        ),
        minimumSize: MaterialStateProperty.resolveWith(
          (states) => Size(double.infinity, 60),
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 20,
            fontFamily: 'Gilroy',
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.white,
        ),
        elevation: MaterialStateProperty.resolveWith(
          (states) => 0,
        ),
        // bottom 3 r not working
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.grey,
        ),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) => Colors.grey,
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) => TextStyle(
            color: Colors.grey[500],
            fontFamily: 'Gilroy',
          ),
        ),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        side: MaterialStateProperty.resolveWith(
          (states) => BorderSide(color: Colors.grey[300]),
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      height: 60,
      minWidth: double.infinity,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      buttonColor: Color(0xff1477f8),
    ),
    dividerTheme: DividerThemeData(
      thickness: 2,
    ),
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      // default text, textField text
      bodyText2: TextStyle(
        color: Colors.white,
        fontFamily: 'Gilroy',
        letterSpacing: 0.4,
      ),
      // for info
      subtitle1: TextStyle(
        color: Colors.grey[300],
        fontFamily: 'Gilroy',
      ),
      // for @mentions
      subtitle2: TextStyle(
        color: Colors.blue[800],
        fontSize: 16,
        fontFamily: 'Gilroy',
      ),
      // for welcome text
      headline6: TextStyle(
        color: Colors.grey[300],
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Gilroy',
      ),
      // for textFieldHeading text
      headline5: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: 'Gilroy',
      ),
      headline4: TextStyle(
        color: Colors.grey[100],
        fontSize: 22,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
        letterSpacing: 0.6,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Color(0xff1f2930),
      contentPadding: EdgeInsets.all(21),
    ),
  );
  ThemeData currentTheme = myLight;
  void setCurrentTheme(int type) {
    switch (type) {
      case 0:
        currentTheme = myLight;
        break;
      case 1:
        currentTheme = myDark;
        break;
    }
    notifyListeners();
  }
}
