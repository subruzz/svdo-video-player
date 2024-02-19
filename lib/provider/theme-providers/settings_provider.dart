import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Filter { darkMode, showRecents }

class SettingsProvider extends StateNotifier<Map<Filter, bool>> {
  SettingsProvider()
      : super({
          Filter.darkMode: true,
          Filter.showRecents: true,
        }) {
    _init();
  }
  late SharedPreferences prefs;
  Future _init() async {

    prefs = await SharedPreferences.getInstance();
    var darkMode = prefs.getBool("appTheme");
    var showRecent = prefs.getBool("showRecent");

    state = {
      Filter.darkMode: darkMode ?? true,
      Filter.showRecents: showRecent ?? true
    };
  }

  void changeSettings(bool value, Filter filter) {
    state = {...state, filter: value};
    switch (filter) {
      case Filter.darkMode:
        prefs.setBool("appTheme", value);
        break;
      case Filter.showRecents:
        prefs.setBool("showRecent", value);
    }
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsProvider, Map<Filter, bool>>(
        (ref) => SettingsProvider());
