import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projectwork/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  final themeService = await ThemeService.instance;
  dynamic initTheme = themeService.initial;
  runApp(
    ProviderScope(
      child: CustomApp(theme: initTheme),
    ),
  );
}

class CustomApp extends ConsumerStatefulWidget {
  final ThemeData theme;

  const CustomApp({
    Key? key,
    required this.theme,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CustomAppState();
}

class CustomAppState extends ConsumerState<CustomApp> {
  @override
  Widget build(BuildContext context) {
    // get a reference to the themeProvider
    final themeController = ref.watch(themeProvider);
    // if the widget.theme is dark
    if (widget.theme == darkTheme) {
      // set the theme to dark
      themeController.activeTheme = true;
    } else {
      // set the theme to light
      themeController.activeTheme = false;
    }

    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return ThemeProvider(
          initTheme: widget.theme,
          builder: (_, theme) => MaterialApp(
            title: BrandStrings.appName.toString(),
            debugShowCheckedModeBanner: false,
            theme: theme,
            themeMode: ThemeMode.light,
            home: const SplashScreen(),
            routes: {
              // screens
              SplashScreen.id: (context) => const SplashScreen(),
              HomeScreen.id: (context) => const HomeScreen(),
              BoardingScreen.id: (context) => const BoardingScreen(),
              // pages
              HomePage.id: (context) => const HomePage(),
              ProfilePage.id: (context) => const ProfilePage(),
              SettingsPage.id: (context) => const SettingsPage(),
              PatientPage.id: (context) => const PatientPage(),
            },
          ),
        );
      },
    );
  }
}
