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
    final userController = ref.watch(userProvider);
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
                        color: themeController.darkTheme ? BrandColors.white : BrandColors.kButtonBlue,
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
            color: themeController.darkTheme ? BrandColors.kColorWhiteAccent : BrandColors.black,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          CustomText(
            text: "keren@gmail.com",
            color: themeController.darkTheme ? BrandColors.kColorWhiteAccent : BrandColors.black,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
        ],
      ),
    );

    Widget header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        profileInfo,
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, SettingsPage.id);
          },
          child: Icon(
            LineAwesomeIcons.cog,
            color: themeController.darkTheme ? BrandColors.kColorWhiteAccent : BrandColors.black,
            size: ScreenUtil().setSp(kSpacingUnit.w * 3),
          ),
        ),
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
                        onPressed: () async {
                          userController.logout();
                          if (!userController.isUserLoggedIn) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              BoardingScreen.id,
                              (route) => false,
                            );
                          }
                        },
                        icon: LineAwesomeIcons.alternate_sign_out,
                        text: 'Logout',
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
