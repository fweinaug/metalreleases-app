import 'package:flutter/material.dart';
import 'package:albumreleases_app/ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color accentColor = Colors.blue[400];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metal Releases',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.grey[900],
        primaryColorLight: Colors.grey[500],
        primaryColorDark: Colors.black,
        toggleableActiveColor: accentColor,
        accentColor: accentColor,
        secondaryHeaderColor: Colors.grey[700],
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: accentColor,
            letterSpacing: 0.2,
          ),
          subtitle2: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          caption: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      home: Home()
    );
  }
}