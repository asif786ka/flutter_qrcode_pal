import 'about.dart';
import 'category.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:ads/ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:save_in_gallery/save_in_gallery.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class GeneratorScreen extends StatefulWidget {
  final String cat;
  final Color color;
  final IconData iconData;
  final Ads appAds;

  const GeneratorScreen(
      {Key key, this.cat, this.color, this.iconData, this.appAds})
      : super(key: key);
  @override
  _GeneratorScreenState createState() => _GeneratorScreenState();
}

class _GeneratorScreenState extends State<GeneratorScreen> {
  var appId = 'ca-app-pub-7341745842244329~6130450429';

  var bannerUnitId = 'ca-app-pub-7341745842244329/3804504135';

  Ads ads;
  @override
  void initState() {
    super.initState();
    widget.appAds.showBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    widget.appAds.dispose();
  }

  final _imageSaver = ImageSaver();
  String qr, qr1, qr2;
  var skey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: skey,
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: waveClipper,
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
                        Navigator.pop(context);
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
                Hero(
                  tag: widget.iconData,
                  child: Icon(
                    widget.iconData,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Generator',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Text(
                  widget.cat,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                SizedBox(height: 80.0),
                Center(
                  child: makeCard(context, widget.cat),
                ),
                qr == null || qr == "" ? SizedBox() : generate(qr),
              ],
            )
          ],
        ));
  }

  bool isHidden = true;

  makeCard(BuildContext context, cat) {
    switch (cat) {
      case 'Wifi':
        return Card(
            elevation: 5,
            // color: widget.color ?? Colors.blue,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter SSid',
                        hintMaxLines: 10),
                    onChanged: (v) {
                      setState(() {
                        qr1 = v;
                        qr = "WIFI:T:WPA;S:+$qr1+;P:+$qr2+;;";
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    obscureText: isHidden,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(isHidden
                              ? Icons.remove_red_eye
                              : MdiIcons.eyeOff),
                          onPressed: () {
                            setState(() {
                              isHidden = !isHidden;
                            });
                          },
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Enter wifi password',
                        hintMaxLines: 10),
                    onChanged: (v) {
                      setState(() {
                        qr2 = v;
                        qr = "WIFI:T:WPA;S:$qr1;P:$qr2;;";
                      });
                    },
                  ),
                ),
                OutlineButton(
                  child: Text(
                      qr != null ? 'Save to gallery' : 'Enter to generate'),
                  onPressed: () {
                    if (qr != null) takeScreenShot();
                  },
                )
              ],
            ));
        break;
      case 'Text':
        return Card(
            elevation: 5,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter or paste your text',
                        hintMaxLines: 10),
                    onChanged: (v) {
                      setState(() {
                        qr = v;
                      });
                    },
                  ),
                ),
                OutlineButton(
                  child: Text(
                      qr != null ? 'Save to gallery' : 'Enter to generate'),
                  onPressed: () {
                    if (qr != null) takeScreenShot();
                  },
                )
              ],
            ));
        break;
      case 'Url':
        return Card(
            elevation: 5,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter or paste your url',
                        hintMaxLines: 10),
                    onChanged: (v) {
                      setState(() {
                        qr = v;
                      });
                    },
                  ),
                ),
                OutlineButton(
                  child: Text(
                      qr != null ? 'Save to gallery' : 'Enter to generate'),
                  onPressed: () {
                    if (qr != null) takeScreenShot();
                  },
                )
              ],
            ));
        break;
      case 'Contact':
        return Card(
            elevation: 5,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Name',
                        hintMaxLines: 10),
                    onChanged: (v) {
                      setState(() {
                        qr1 = v;
                        qr = "MECARD:N:$qr1;TEL:$qr2;;";
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Phone number',
                        hintMaxLines: 10),
                    onChanged: (v) {
                      setState(() {
                        qr2 = v;
                        qr = "MECARD:N:$qr1;TEL:$qr2;;";
                      });
                    },
                  ),
                ),
                OutlineButton(
                  child: Text(
                      qr != null ? 'Save to gallery' : 'Enter to generate'),
                  onPressed: () {
                    if (qr != null) takeScreenShot();
                  },
                )
              ],
            ));
        break;

      case 'Location':
        return Card(
            elevation: 5,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Latitude',
                        hintMaxLines: 10),
                    onChanged: (v) {
                      setState(() {
                        qr1 = v;
                        qr = "http://maps.google.com?q=$qr1,$qr2";
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Longitude',
                        hintMaxLines: 10),
                    onChanged: (v) {
                      setState(() {
                        qr = v;
                        qr = "http://maps.google.com?q=$qr1,$qr2";
                      });
                    },
                  ),
                ),
                OutlineButton(
                  child: Text(
                      qr != null ? 'Save to gallery' : 'Enter to generate'),
                  onPressed: () {
                    if (qr != null) takeScreenShot();
                  },
                )
              ],
            ));
        break;
      case 'Email':
        return Card(
            elevation: 5,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter or paste Email',
                        hintMaxLines: 10),
                    onChanged: (v) {
                      setState(() {
                        qr = "EMAIL:$v";
                      });
                    },
                  ),
                ),
                OutlineButton(
                  child: Text(
                      qr != null ? 'Save to gallery' : 'Enter to generate'),
                  onPressed: () {
                    if (qr != null) takeScreenShot();
                  },
                )
              ],
            ));
        break;

      default:
        break;
    }
  }

  var directory;
  Uint8List pngBytes;
  var key = GlobalKey();
  takeScreenShot() async {
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    final res = await _imageSaver.saveImage(
        imageBytes: pngBytes, directoryName: 'qrboss');
    res
        ? skey.currentState.showSnackBar(SnackBar(
            content: Text('Sucessfully saved'),
            backgroundColor: Colors.green,
          ))
        : skey.currentState.showSnackBar(SnackBar(
            content: Text('Something went wrong  try again'),
            backgroundColor: Colors.red,
          ));
    widget.appAds.showFullScreenAd();
  }

  generate(message) {
    return RepaintBoundary(
      key: key,
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: QrImage(
          data: message,
          version: QrVersions.auto,
          size: 320,
        ),
      ),
    );
  }
}
