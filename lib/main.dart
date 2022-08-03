import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projectwork/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

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
    ref.read(themeProvider.notifier).load(); // load the theme from themeController
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = ref.watch(themeProvider); // get a reference to the themeProvider

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
            home: const HomeScreen(),
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
