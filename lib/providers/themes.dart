import '../helper.dart';

class MyTheme extends ChangeNotifier {
  static ThemeData myLight = ThemeData.light().copyWith(
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
          ),
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
      bodyText2: TextStyle(color: Colors.black),
      // for info
      subtitle1: TextStyle(color: Colors.grey[500]),
      // for @mentions
      subtitle2: TextStyle(
        color: Colors.blue[800],
        fontSize: 16,
      ),
      // for welcome text
      headline6: TextStyle(
        color: Colors.grey[500],
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      // for textFieldHeading text
      headline5: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      headline4: TextStyle(
        color: Colors.grey[700],
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      filled: true,
      fillColor: Colors.white,
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
        currentTheme = ThemeData.dark();
        break;
    }
    notifyListeners();
  }
}
