import 'package:ads/ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'richtext.dart';

class QqrScannerScreen extends StatefulWidget {
  final PageController pageController;
  final Ads appAds;
  final bool has;

  const QqrScannerScreen({Key key, this.pageController, this.appAds, this.has})
      : super(key: key);
  @override
  _QqrScannerScreenState createState() => _QqrScannerScreenState();
}

class _QqrScannerScreenState extends State<QqrScannerScreen> {
  var qrText = "";

  var cameraState = front_camera;
  QRViewController controller;
  var flashState = flash_on;
  final key = GlobalKey<ScaffoldState>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller.dispose();
    widget.appAds.dispose();
    super.dispose();
  }

  _isFlashOn(String current) {
    return flash_on == current;
  }

  _isBackCamera(String current) {
    return back_camera == current;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });

      show();
      //  dispose();
      controller.pauseCamera();
      persistentBottomSheetController.closed.then((s) {
        controller.resumeCamera();
      });
    });
  }

  PersistentBottomSheetController persistentBottomSheetController;
  show() {
    persistentBottomSheetController = key.currentState.showBottomSheet(
      (context) {
        return Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5),
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Scan result',
                style: TextStyle(fontSize: 50),
              ),
              Icon(
                MdiIcons.qrcodeScan,
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(child: RichTextView(qrText)),
              OutlineButton.icon(
                label: Text('Copy'),
                onPressed: () {
                  Clipboard.setData(new ClipboardData(text: qrText));
                  Navigator.pop(context);
                  key.currentState.showSnackBar(SnackBar(
                    content: Text('copied'),
                    backgroundColor: Colors.green,
                  ));

                  widget.appAds.showFullScreenAd(state: this);
                  controller.resumeCamera();
                },
                icon: Icon(MdiIcons.contentCopy),
              ),
              Text('If link then click pn it to visit')
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      color: Colors.white,
                      icon: Icon(
                        _isFlashOn(flashState)
                            ? MdiIcons.flashOutline
                            : Icons.flash_off,
                        size: 25,
                      ),
                      onPressed: () {
                        if (controller != null) {
                          controller.toggleFlash();
                          if (_isFlashOn(flashState)) {
                            setState(() {
                              flashState = flash_off;
                            });
                          } else {
                            setState(() {
                              flashState = flash_on;
                            });
                          }
                        }
                      },
                    ),
                    IconButton(
                      color: Colors.white,
                      icon: Icon(
                        _isBackCamera(cameraState)
                            ? MdiIcons.cameraWirelessOutline
                            : MdiIcons.cameraFront,
                        size: 25,
                      ),
                      onPressed: () {
                        if (controller != null) {
                          controller.flipCamera();
                          if (_isBackCamera(cameraState)) {
                            setState(() {
                              cameraState = front_camera;
                            });
                          } else {
                            setState(() {
                              cameraState = back_camera;
                            });
                          }
                        }
                      },
                    )
                  ],
                ),
                Text(
                  'Place the Qr/bar code inside frame below',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: OutlineButton.icon(
                color: Colors.red,
                icon: Icon(
                  MdiIcons.qrcodePlus,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  widget.pageController.nextPage(
                      curve: Curves.decelerate,
                      duration: Duration(milliseconds: 200));
                },
                label: Text(
                  'Qr Generator',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 3,
              child: Text(
                'If camera goes black try rotating the camera',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const flash_on = "FLASH ON";
const flash_off = "FLASH OFF";
const front_camera = "FRONT CAMERA";
const back_camera = "BACK CAMERA";
