import 'package:ads/ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'about.dart';
import 'generator.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen(
      {Key key, this.pageController})
      : super(key: key);

  final PageController pageController;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  @override
  void initState() {
    super.initState();
  }

  buildButton(BuildContext context, icon, text, {color = Colors.blue}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GeneratorScreen(
                      cat: text,
                      color: color,
                      iconData: icon,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: color,
          ),
          constraints: BoxConstraints(minWidth: 150, minHeight: 150),
          child: Center(
            child: Column(
              children: <Widget>[
                Hero(
                  child: Icon(icon),
                  tag: icon,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.blueAccent,
                  Theme.of(context).primaryColor
                ])),
                height: 350,
              ),
            ),
            ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        widget.pageController.previousPage(
                            curve: Curves.linear,
                            duration: Duration(milliseconds: 200));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutScreen()));
                      },
                    )
                  ],
                ),
                SizedBox(height: 50.0),
                Icon(
                  MdiIcons.qrcodePlus,
                  size: 50,
                  color: Colors.white,
                ),
                Text(
                  'Generator',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Text(
                  'Choose Category',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                SizedBox(height: 80.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    buildButton(context, MdiIcons.text, 'Text',
                        color: Colors.amberAccent),
                    buildButton(context, MdiIcons.contactPhone, 'Contact',
                        color: Colors.orangeAccent),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    buildButton(
                      context,
                      MdiIcons.wifi,
                      'Wifi',
                      color: Colors.deepOrangeAccent,
                    ),
                    buildButton(context, MdiIcons.locationEnter, 'Location',
                        color: Colors.amber),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    buildButton(context, MdiIcons.link, 'Url',
                        color: Colors.greenAccent),
                    buildButton(context, MdiIcons.email, 'Email',
                        color: Colors.cyan),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);

    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    var firstControlPoint = Offset(size.width / 4, size.height - 53);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondEndPoint = Offset(size.width, size.height - 90);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 14);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

final waveClipper = WaveClipper();
