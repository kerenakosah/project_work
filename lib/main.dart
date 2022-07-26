import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = await ThemeService.instance;
  dynamic initTheme = themeService.initial;
  runApp(
    CustomApp(theme: initTheme),
  );
}

class CustomApp extends StatelessWidget {
  final ThemeData theme;

  const CustomApp({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: theme,
      builder: (_, theme) => MaterialApp(
        title: BrandStrings.appName.toString(),
        debugShowCheckedModeBanner: false,
        theme: theme,
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
