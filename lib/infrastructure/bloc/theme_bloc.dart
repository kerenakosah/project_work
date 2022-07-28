import 'package:hooks_riverpod/hooks_riverpod.dart';

// create a class that will be used to store the theme
class Theme {
  bool activeTheme = false;
}

// create a provider for the theme
final themeProvider = StateProvider<Theme>((ref) {
  return Theme();
});
