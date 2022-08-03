import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:projectwork/index.dart';

class SettingsPage extends ConsumerStatefulWidget {
  static const id = BrandStrings.settingsPage;
  const SettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    // get a reference to the themeProvider
    final themeController = ref.watch(themeProvider);
    const kSpacingUnit = 10;

    ThemeSwitcher themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: ThemeModelInheritedNotifier.of(context).theme.brightness == Brightness.dark ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () {
              ThemeSwitcher.of(context).changeTheme(
                theme: BrandThemes.lightTheme(context),
              );
              ref.read(themeProvider.notifier).toggle();
            },
            child: Icon(
              LineAwesomeIcons.sun,
              color: themeController.darkTheme ? BrandColors.kColorWhiteAccent : BrandColors.black,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () {
              ThemeSwitcher.of(context).changeTheme(
                theme: BrandThemes.darkTheme(context),
              );
              ref.read(themeProvider.notifier).toggle();
            },
            child: Icon(
              LineAwesomeIcons.moon,
              color: themeController.darkTheme ? BrandColors.kColorWhiteAccent : BrandColors.black,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
        );
      },
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: kSpacingUnit.w * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        LineAwesomeIcons.angle_left,
                        color: themeController.darkTheme ? BrandColors.white : BrandColors.black,
                        size: ScreenUtil().setSp(kSpacingUnit.w * 3),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(child: Container()),
                    SizedBox(width: kSpacingUnit.w * 3),
                    themeSwitcher,
                    SizedBox(width: kSpacingUnit.w * 1.5),
                  ],
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      ProfileListItem(
                        icon: LineAwesomeIcons.user_shield,
                        text: 'Privacy Policy',
                        bgColor: themeController.darkTheme ? BrandColors.white : BrandColors.black,
                        iconColor: themeController.darkTheme ? BrandColors.black : BrandColors.white,
                        textColor: themeController.darkTheme ? BrandColors.black : BrandColors.white,
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.history,
                        text: 'History',
                        bgColor: themeController.darkTheme ? BrandColors.white : BrandColors.black,
                        iconColor: themeController.darkTheme ? BrandColors.black : BrandColors.white,
                        textColor: themeController.darkTheme ? BrandColors.black : BrandColors.white,
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.question_circle,
                        text: 'Help & Support',
                        bgColor: themeController.darkTheme ? BrandColors.white : BrandColors.black,
                        iconColor: themeController.darkTheme ? BrandColors.black : BrandColors.white,
                        textColor: themeController.darkTheme ? BrandColors.black : BrandColors.white,
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.user_plus,
                        text: 'Invite a Friend',
                        bgColor: themeController.darkTheme ? BrandColors.white : BrandColors.black,
                        iconColor: themeController.darkTheme ? BrandColors.black : BrandColors.white,
                        textColor: themeController.darkTheme ? BrandColors.black : BrandColors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
