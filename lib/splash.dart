import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'home.dart';

class IntroSliderScreen extends StatefulWidget {
  @override
  _IntroSliderScreenState createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (predicate) => false);
    });
  }

  getPage({
    title,
    subtitle,
  }) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Icon(
                  MdiIcons.qrcode,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 42, color: Colors.white),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  subtitle.toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: PageView(
            children: <Widget>[
              getPage(
                title: 'Qr Boss',
                subtitle: 'The ultimate qr scanner',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
