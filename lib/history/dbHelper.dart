import 'dart:convert';
import 'package:QrBoss/history/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  SharedPreferences _preferences;

  PreferenceHelper() {
    initAsync();
  }

  initAsync() async {
    _preferences = await SharedPreferences.getInstance();
  }

  storeHistory(List<History> history) async {
    if (_preferences == null) await initAsync();

    var dData = history.map<dynamic>((p) => p.toMap()).toList();

    await _preferences.setString("history", json.encode(dData));
  }

  Future clear() async {
    if (_preferences == null) await initAsync();

    await _preferences.remove("history");
  }

  Future<List<History>> getHistory() async {
    if (_preferences == null) await initAsync();

    List<History> history = [];
    var sData = _preferences.getString("history");
    if (sData != null) {
      var dData = json.decode(sData);
      history = dData.map<History>((d) => History.fromMap(d)).toList();
    }
    return history;
  }
}
