import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeNotifier extends StateNotifier<bool> {
  late SharedPreferences prefs;

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    final darkMode = prefs.getBool('darkMode') ?? false;
    state = darkMode;
  }

  DarkModeNotifier() : super(false) {
    _init();
  }

  void toggleDarkMode() async {
    state = !state;
    await prefs.setBool('darkMode', state);
  }
}

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>(
  (ref) => DarkModeNotifier(),
);
