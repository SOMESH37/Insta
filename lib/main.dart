import 'helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

class App extends StatelessWidget {
  final isAuth = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyTheme()),
        ChangeNotifierProvider(create: (_) => BottomNavBar()),
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
            home:ValueListenableBuilder(
              valueListenable: isAuth,
              builder: (_, value, __) => value
                  ? 
                  // UI for home is inside 'Main'
                  Main()
                  : 
                  /* if you want to implement authentication
                     - remove 'Stack' widget
                     - use state management
                     - 'LandingPage' contains UI for that
                   */
                  Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Navigator(
                            onGenerateRoute: (settings) => MaterialPageRoute(
                                builder: (context) => LandingPage())),
                        SafeArea(
                          child: TextButton(
                            onPressed: () {
                              isAuth.value = true;
                            },
                            child: Text(
                              'Inside App >',
                              style: Theme.of(cxt)
                                  .textTheme
                                  .headline6
                                  .apply(color: Colors.blue[300]),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
