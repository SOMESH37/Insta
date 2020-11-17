import 'helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MyTheme(),
        ),
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavBar(),
        ),
      ],
      builder: (cxt, _) {
        return NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification over) {
            over.disallowGlow();
            return;
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            // debugShowMaterialGrid: true,
            theme: Provider.of<MyTheme>(cxt).currentTheme,
            home: true ? Main() : LandingPage(),
          ),
        );
      },
    );
  }
}
