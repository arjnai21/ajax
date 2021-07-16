// @dart=2.9
// ^ to avoid strange null safety issues that I don't really understand but should probably look into
import 'package:flutter/material.dart';
import 'package:ajax/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget{
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Map<int, Color> color =
    {
      50: Color.fromRGBO(136,14,79, .1),
      100: Color.fromRGBO(136,14,79, .2),
      200: Color.fromRGBO(136,14,79, .3),
      300: Color.fromRGBO(136,14,79, .4),
      400: Color.fromRGBO(136,14,79, .5),
      500: Color.fromRGBO(136,14,79, .6),
      600: Color.fromRGBO(136,14,79, .7),
      700: Color.fromRGBO(136,14,79, .8),
      800: Color.fromRGBO(136,14,79, .9),
      900: Color.fromRGBO(136,14,79, 1),
    };
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError){
          print("error");
          throw("wasnt able to initialize firebase");
        }

        else if(snapshot.connectionState == ConnectionState.done){
          return  MaterialApp(
            title: 'ajax',
            theme: ThemeData(
                primarySwatch: MaterialColor(0xFF333333, color),
                accentColor: Color.fromRGBO(164, 19, 220, 1.0),
                scaffoldBackgroundColor: const Color(111111),
                textTheme: TextTheme(
                  headline6: TextStyle(color: Colors.white, fontFamily: "Roboto", decoration: TextDecoration.underline, decorationColor: Colors.white),
                  bodyText1: TextStyle(color: Colors.white),
                  headline3: TextStyle(color: Colors.white, fontFamily: "Roboto"),
                  subtitle1: TextStyle(color: Colors.white, fontFamily: "Roboto"),
                )
            ),
            home: HomePage(title: 'ajax'),
            debugShowCheckedModeBanner: false,

          );
        }
        else{
          return CircularProgressIndicator();
        }
      },
    );

  }
}

