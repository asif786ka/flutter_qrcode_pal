import 'dart:async';
import 'package:ads/ads.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '404.dart';
import 'category.dart';
import 'scanner.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  Ads appAds;
  //place your appID,banneradID,InterestialAdId(screenUnitId) from admob
  var bannerUnitId = 'ca-app-pub-7341745842244329/3804504135';
  var appId = 'ca-app-pub-7341745842244329~6130450429';
  var screenUnitId = 'ca-app-pub-7341745842244329/7060388713';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool hasConnection = false;

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return;
    }

    _updateConnectionStatus(result);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    appAds.dispose();
    super.dispose();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        setState(() {
          hasConnection = true;
        });

        break;
      case ConnectivityResult.mobile:
        setState(() {
          hasConnection = true;
        });
        break;
      case ConnectivityResult.none:
        setState(() => hasConnection = false);
        break;
      default:
        setState(() => hasConnection = false);
        break;
    }
  }

  FirebaseMessaging _messaging = FirebaseMessaging();
  onNotificationClick({context, onLaunch, onResume}) {
    _messaging.configure(onLaunch: (message) {
      onLaunch(message);
      return null;
    }, onResume: (message) {
      onResume(message);
      return null;
    });
  }

  void handleNotification(message) {
    String url = message['data']['screen'] as String;
    String link = message['data']['link'] as String;
    switch (url) {
      case '/notification':
        break;
      case '/ads':
        {
          launch(link);
        }
        break;

      default:
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Custom404Screen()));
        }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _messaging.subscribeToTopic('all_users');
    onNotificationClick(
        context: context,
        onLaunch: (message) {
          handleNotification(message);
        },
        onResume: (message) {
          handleNotification(message);
        });
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    var eventListner = (MobileAdEvent event) {
      switch (event) {
        case MobileAdEvent.loaded:
          break;

        case MobileAdEvent.failedToLoad:
          break;
        case MobileAdEvent.clicked:
          break;
        case MobileAdEvent.impression:
          break;
        case MobileAdEvent.opened:
          break;
        case MobileAdEvent.leftApplication:
          break;
        case MobileAdEvent.closed:
          break;
      }
    };
    appAds = Ads(
      appId,
      screenUnitId: screenUnitId,
      bannerUnitId: bannerUnitId,
      listener: eventListner,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: <Widget>[
            QqrScannerScreen(
              pageController: pageController,
              appAds: appAds,
              has: hasConnection,
            ),
            CategoryScreen(
              pageController: pageController
            )
          ],
          controller: pageController,
        ),
      ),
    );
  }
}
