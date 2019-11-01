import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height),
        color: Theme.of(context).primaryColor,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Icon(
              MdiIcons.qrcode,
              size: 100,
              color: Colors.white,
            ),
            Text(
              'Qr Boss',
              style: TextStyle(fontSize: 42, color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'Qr boss is an Qr/Bar code scanner and generator app that help you to scan qr codes quickly and easily anywhere anytime.Enjoy the app and don\'t forget to rate it in playstore. ',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    TextSpan(
                        text: 'Click here to read privacy policy',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 19,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://qrboss-privacy.surge.sh');
                          }),
                  ],
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Text(
              'Developer contact ',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    MdiIcons.instagram,
                    color: Colors.pinkAccent,
                  ),
                  onPressed: () async {
                    const url = 'https://www.instagram.com/cimplesid';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                IconButton(
                  icon:
                      Icon(MdiIcons.googlePlay, color: Colors.lightGreenAccent),
                  onPressed: () {
                    launch(
                        'https://play.google.com/store/apps/developer?id=Quotes+Nepal');
                  },
                ),
                IconButton(
                  icon: Icon(MdiIcons.githubCircle, color: Colors.black),
                  onPressed: () {
                    launch('https://www.github.com/cimplesid');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
