import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projectwork/index.dart';

Future<void> main() async {
  // ensure widgets are initialized
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // initialize firebase
  await Firebase.initializeApp(
    name: BrandStrings.appName.toString(),
    options: DefaultFirebaseConfig.platformOptions,
  );

  runApp(
    const ProviderScope(
      child: CustomApp(),
    ),
  );
}

class CustomApp extends ConsumerStatefulWidget {
  const CustomApp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CustomAppState();
}

class CustomAppState extends ConsumerState<CustomApp> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    ref.read(themeProvider.notifier).load(); // load the theme from themeController
    ref.read(userProvider).initUser(); // load the user from userController
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ref.read(themeProvider); // get a reference to the themeProvider
    final userController = ref.watch(userProvider);

    return ScreenUtilInit(
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child) {
        return ThemeProvider(
          initTheme: themeController.lightTheme ? BrandThemes.lightTheme(context) : BrandThemes.darkTheme(context),
          builder: (_, theme) => MaterialApp(
            title: BrandStrings.appName.toString(),
            debugShowCheckedModeBanner: false,
            theme: themeController.lightTheme ? BrandThemes.lightTheme(context) : BrandThemes.darkTheme(context),
            themeMode: ThemeMode.light,
            home: userController.isUserLoggedIn ? const HomeScreen() : const SplashScreen(),
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
