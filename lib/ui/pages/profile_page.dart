import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:projectwork/index.dart';

class ProfilePage extends ConsumerStatefulWidget {
  // page id
  static const id = BrandStrings.profilePage;
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // get a reference to the themeProvider
    final themeController = ref.watch(themeProvider);
    const kSpacingUnit = 10;
    Widget profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                SvgPicture.asset(
                  Assets.svgAccount,
                  width: 200.0,
                  height: 200.0,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: Icon(
                        LineAwesomeIcons.edit,
                        color: themeController.activeTheme ? BrandColors.kPrimaryBackgroundColor : BrandColors.kColorWhiteAccent,
                        size: ScreenUtil().setSp(kSpacingUnit.w * 2.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          CustomText(
            text: "hello Keren",
            color: themeController.activeTheme ? BrandColors.kColorText : BrandColors.kColorWhiteAccent,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          CustomText(
            text: "keren@gmail.com",
            color: themeController.activeTheme ? BrandColors.kColorText : BrandColors.kColorWhiteAccent,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
        ],
      ),
    );

    ThemeSwitcher themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: ThemeModelInheritedNotifier.of(context).theme.brightness == Brightness.dark ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () {
              ThemeSwitcher.of(context).changeTheme(
                theme: lightTheme,
              );
              themeController.activeTheme = !themeController.activeTheme;
            },
            child: Icon(
              LineAwesomeIcons.sun,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () {
              ThemeSwitcher.of(context).changeTheme(
                theme: darkTheme,
              );
              themeController.activeTheme = !themeController.activeTheme;
            },
            child: Icon(
              LineAwesomeIcons.moon,
              color: themeController.activeTheme ? BrandColors.black : BrandColors.kColorWhiteAccent,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
        );
      },
    );

    Widget header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        profileInfo,
        themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 1.5),
      ],
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: kSpacingUnit.w * 1),
                header,
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      ProfileListItem(
                        icon: LineAwesomeIcons.user_shield,
                        text: 'Privacy Policy',
                        iconColor: themeController.activeTheme ? BrandColors.white : BrandColors.black,
                        bgColor: themeController.activeTheme ? BrandColors.black : BrandColors.kColorWhiteAccent,
                        textColor: themeController.activeTheme ? BrandColors.kColorWhiteAccent : BrandColors.kColorText,
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.history,
                        text: 'History',
                        iconColor: themeController.activeTheme ? BrandColors.white : BrandColors.black,
                        bgColor: themeController.activeTheme ? BrandColors.black : BrandColors.kColorWhiteAccent,
                        textColor: themeController.activeTheme ? BrandColors.kColorWhiteAccent : BrandColors.kColorText,
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.question_circle,
                        text: 'Help & Support',
                        iconColor: themeController.activeTheme ? BrandColors.white : BrandColors.black,
                        bgColor: themeController.activeTheme ? BrandColors.black : BrandColors.kColorWhiteAccent,
                        textColor: themeController.activeTheme ? BrandColors.kColorWhiteAccent : BrandColors.kColorText,
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.cog,
                        text: 'Settings',
                        iconColor: themeController.activeTheme ? BrandColors.white : BrandColors.black,
                        bgColor: themeController.activeTheme ? BrandColors.black : BrandColors.kColorWhiteAccent,
                        textColor: themeController.activeTheme ? BrandColors.kColorWhiteAccent : BrandColors.kColorText,
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.user_plus,
                        text: 'Invite a Friend',
                        iconColor: themeController.activeTheme ? BrandColors.white : BrandColors.black,
                        bgColor: themeController.activeTheme ? BrandColors.black : BrandColors.kColorWhiteAccent,
                        textColor: themeController.activeTheme ? BrandColors.kColorWhiteAccent : BrandColors.kColorText,
                      ),
                      ProfileListItem(
                        onPressed: () async {
                          // await authRepo.signOut();
                          // userController.initUser();
                          // if (!userController.isUserLoggedIn) {
                          //   NavigationService.navigateTo(
                          //     isNamed: true,
                          //     page: RoutePaths.authLogin,
                          //     navigationMethod: NavigationMethod.pushReplacement,
                          //   );
                          // }
                        },
                        icon: LineAwesomeIcons.alternate_sign_out,
                        text: 'Logout',
                        iconColor: themeController.activeTheme ? BrandColors.white : BrandColors.black,
                        bgColor: themeController.activeTheme ? BrandColors.black : BrandColors.kColorWhiteAccent,
                        textColor: themeController.activeTheme ? BrandColors.kColorWhiteAccent : BrandColors.kColorText,
                        hasNavigation: false,
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
