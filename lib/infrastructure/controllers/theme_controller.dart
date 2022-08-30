import 'package:get/get.dart';
import 'package:projectwork/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static ThemeController instance = Get.find();

  final _isLightTheme = true.obs; // true for light theme, false for dark theme

  // change the theme
  toggleTheme() {
    _isLightTheme.value = !_isLightTheme.value;
    _saveThemeStatus();
  }

  // change theme from shared pref
  initTheme() async {
    SharedPreferences prefs = await sharedPreferences;
    _isLightTheme.value = prefs.getBool('theme') ?? true;
  }

  _saveThemeStatus() async {
    SharedPreferences pref = await sharedPreferences;
    pref.setBool('theme', isLightTheme);
  }

  // is light theme active
  bool get isLightTheme => _isLightTheme.value;
}
