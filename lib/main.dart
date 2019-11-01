import 'package:flutter/material.dart';

import 'splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qr Boss',
      theme: ThemeData(
        // This is the theme of your application.
        // u can change the primarycolor using primaryColor argument
        // [primaryColor:Colors.red] this is and example here
        primarySwatch: Colors.blue,
        accentColor: Colors.amberAccent
      ),
      home: IntroSliderScreen(),
    );
  }
}
