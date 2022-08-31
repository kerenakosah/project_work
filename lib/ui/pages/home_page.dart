import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:projectwork/index.dart';

class HomePage extends StatefulWidget {
  // page id
  static const id = BrandStrings.homePage;
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [
                    BrandColors.lightGreen.withOpacity(0.6),
                    BrandColors.colorDarkGreen.withOpacity(0.8),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  // topLeft: Radius.circular(180.0),
                  // topRight: Radius.circular(80.0),
                  // bottomLeft: Radius.circular(280.0),
                  bottomRight: Radius.circular(180.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  top: 50.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Obx(
                          () => CustomText(
                            text: "Welcome back \n${userController.currentUserInfo.firstName ?? " "}",
                            color: BrandColors.black,
                            fontSize: 24.0,
                            maxLines: 4,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Expanded(child: Container()),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            color: BrandColors.black.withOpacity(0.6),
                            size: 84.0,
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: BrandColors.kColorWhiteAccent,
                child: Stack(
                  children: [
                    Positioned(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            // user icon
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(child: Container()),
                                  IconButton(
                                    onPressed: () {
                                      controller.animateToPage(
                                        2,
                                        duration: const Duration(seconds: 2),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    icon: const Icon(
                                      LineAwesomeIcons.user_circle,
                                      size: 65.0,
                                      color: BrandColors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                ],
                              ),
                            ),
                            const SizedBox(height: 60.0),
                            // alerts box
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // today's alerts
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, MapView.id);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0,
                                        vertical: 50.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: BrandColors.secondaryColor,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: const CustomText(
                                        text: "Today's \nAlerts",
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w600,
                                        color: BrandColors.white,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  // all alerts
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, MapView.id);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0,
                                        vertical: 50.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: BrandColors.colorDarkBlue,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: const CustomText(
                                        text: "All \nAlerts",
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.w600,
                                        color: BrandColors.white,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 60.0),
                            // settings
                            BrandButton(
                              onPressed: () {
                                Navigator.pushNamed(context, SettingsPage.id);
                              },
                              title: "Settings",
                              buttonColor: BrandColors.secondaryColor,
                              fontSize: 22.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.05,
                      right: MediaQuery.of(context).size.width * 0.18,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.02,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(180.0),
                            topRight: Radius.circular(80.0),
                            // bottomLeft: Radius.circular(280.0),
                            // bottomRight: Radius.circular(180.0),
                          ),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: BrandColors.colorDarkGreen.withOpacity(0.5),
                          size: 84.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
