import 'package:flutter/material.dart';
import 'package:grape/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: MaterialColor(0xFF333333, color),
        accentColor: Color.fromRGBO(146, 118, 244, 1),
        scaffoldBackgroundColor: const Color(111111),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          headline3: TextStyle(color: Colors.white, fontFamily: "Roboto")
        )
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

