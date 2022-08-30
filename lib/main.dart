import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:projectwork/index.dart';

Future<void> main() async {
  // ensure widgets are initialized
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // initialize firebase
  await Firebase.initializeApp(
    name: BrandStrings.appName.toString(),
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // initialize services
  InitServices.instance.initServices();

  // run app
  runApp(const CustomApp());
}

class CustomApp extends StatefulWidget {
  const CustomApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomAppState();
}

class _CustomAppState extends State<CustomApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    themeController.initTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return ThemeProvider(
          initTheme: themeController.isLightTheme ? BrandThemes.lightTheme(context) : BrandThemes.darkTheme(context),
          builder: (_, theme) => GetMaterialApp(
            builder: (BuildContext context, Widget? widget) {
              return widget!;
            },
            title: BrandStrings.appName.toString(),
            debugShowCheckedModeBanner: false,
            theme: themeController.isLightTheme ? BrandThemes.lightTheme(context) : BrandThemes.darkTheme(context),
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
