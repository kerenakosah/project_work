import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projectwork/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

// create a class that will be used to store the theme
@immutable
class Theme {
  const Theme({
    required this.lightTheme,
    required this.darkTheme,
  });

  final bool lightTheme;
  final bool darkTheme;

  // copy with
  Theme copyWith({required bool newLightTheme, required bool newDarkTheme}) {
    return Theme(
      lightTheme: newLightTheme,
      darkTheme: newDarkTheme,
    );
  }
}

// create a state notifier provider
class ThemeNotifier extends StateNotifier<Theme> {
  ThemeNotifier()
      : super(
          const Theme(
            lightTheme: true,
            darkTheme: false,
          ),
        );

  // save the theme to shared pref
  save() async {
    // get the active theme
    bool lightTheme = state.lightTheme;
    bool darkTheme = state.darkTheme;
    SharedPreferences prefs = await sharedPreferences;
    prefs.setBool('lightTheme', lightTheme);
    prefs.setBool('darkTheme', darkTheme);
  }

  // load the theme from shared pref
  load() async {
    SharedPreferences prefs = await sharedPreferences;
    state = Theme(
      lightTheme: prefs.getBool('lightTheme') ?? true,
      darkTheme: prefs.getBool('darkTheme') ?? false,
    );
    save();
  }

  // set active theme to false for light theme
  setLightTheme() {
    state = state.copyWith(
      newLightTheme: true,
      newDarkTheme: false,
    );
    save();
  }

  // set active theme to true for dark theme
  setDarkTheme() {
    state = state.copyWith(
      newLightTheme: false,
      newDarkTheme: true,
    );
    save();
  }

  // toggle the active theme
  toggle() {
    // toggle the active theme
    state = state.copyWith(
      newLightTheme: !state.lightTheme,
      newDarkTheme: !state.darkTheme,
    );
    save();
  }
}

// state notifier provider
final themeProvider = StateNotifierProvider<ThemeNotifier, Theme>((ref) {
  return ThemeNotifier();
});
