import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Custom404Screen extends StatelessWidget {
  final String urlString =
      "https://play.google.com/store/apps/details?id=com.sidtube.qr";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "404",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "You lost? Probaly this is a new feature, update the application.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Text("Click here to update"),
                onPressed: () {
                  launch(urlString);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
