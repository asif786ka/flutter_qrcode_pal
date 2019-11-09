import 'category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:QrBoss/history/history.dart';
import 'package:QrBoss/history/dbHelper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<History> historys;
  @override
  void initState() {
    super.initState();
    getHistory();
  }

  getHistory() {
    PreferenceHelper().getHistory().then((h) {
      setState(() {
        this.historys = h;
      });
    });
  }

  show() {
    skey.currentState.showBottomSheet(
      (context) {
        return Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.35),
          width: MediaQuery.of(context).size.width,
          color: Colors.pinkAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Do you want to clear history ?',
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
              Icon(
                MdiIcons.deleteAlert,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  OutlineButton.icon(
                    label: Text('yes'),
                    icon: Icon(MdiIcons.handOkay),
                    onPressed: () {
                      PreferenceHelper().clear();
                      Navigator.pop(context);
                      skey.currentState.showSnackBar(SnackBar(
                        content: Text(
                          'Deleted Sucessfully',
                        ),
                        backgroundColor: Colors.red,
                      ));
                      getHistory();
                    },
                  ),
                  OutlineButton.icon(
                    label: Text('no'),
                    icon: Icon(MdiIcons.swordCross),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  var skey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: skey,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
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
              Column(
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
                      if (historys != null)
                        historys.length < 1
                            ? SizedBox()
                            : IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  show();
                                },
                              )
                    ],
                  ),
                  SizedBox(height: 50.0),
                  Icon(
                    MdiIcons.qrcodeEdit,
                    size: 50,
                    color: Colors.white,
                  ),
                  Text(
                    'History',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Text(
                    'Your scan Records',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  SizedBox(height: 80.0),
                  Expanded(child: getBody())
                ],
              )
            ],
          ),
        ));
  }

  getBody() {
    if (historys == null)
      return SizedBox(
          height: 5,
          width: 5,
          child: CircularProgressIndicator(
            strokeWidth: 1,
          ));
    if (historys.length == 0)
      return Text(
        'No records found',
        style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
      );
    return ListView.builder(
      itemCount: historys.length,
      itemBuilder: (BuildContext context, int index) {
        var history = historys[index];
        String text = getTextFromType(history.type, history.data);
        return Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: ListTile(
            onTap: () async {
              String url = text;
              await launch(url);
            },
            contentPadding: EdgeInsets.all(10),
            trailing: IconButton(
              icon: Icon(MdiIcons.contentCopy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text));
                skey.currentState.showSnackBar(SnackBar(
                  content: Text('Copied Sucessfully'),
                ));
              },
            ),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(getIconFromType(history.type)),
              radius: 30,
            ),
            title: Text(
              history.type,
              style: Theme.of(context)
                  .primaryTextTheme
                  .title
                  .copyWith(color: Colors.black),
            ),
            subtitle: SelectableText(text),
          ),
        );
      },
    );
  }

  getTextFromType(String type, String data) {
    switch (type) {
      case 'Wifi':
        {
          var split = data.split('S:');
          var split1 = split[1].split(';');
          var mid = data.split('P:');
          var split2 = mid[1].split(';');
          return 'SSID:${split1[0]}\nPassword:${split2[0]}';
        }
      case 'Text':
        return data;
      case 'Url':
        return data;
      case 'Location':
        {
          if (data.contains('geo')) {
            var split = data.split(',');
            var split1 = split[0].split(':');
            return 'http://maps.google.com?q=$split1[1],$split[1]';
          }
          return data;
        }

      case 'Contact':
        return data;
      case 'Email':
        {
          var split = data.split('mailto:');
          String dat = split[1];
          return '$dat';
        }
      default:
        return data;
    }
  }

  getIconFromType(String type) {
    switch (type) {
      case 'Wifi':
        return MdiIcons.wifi;
      case 'Text':
        return MdiIcons.text;
      case 'Url':
        return MdiIcons.link;
      case 'Location':
        return MdiIcons.locationEnter;
      case 'Contact':
        return MdiIcons.contactPhone;
      case 'Email':
        return MdiIcons.email;
      default:
        return MdiIcons.qrcodeScan;
    }
  }
}
