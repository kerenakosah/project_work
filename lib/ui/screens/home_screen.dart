import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:projectwork/index.dart';

class HomeScreen extends StatefulWidget {
  // page id
  static const String id = BrandStrings.homeScreen;

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int selectedBottomBarIndex = 0;
  bool _isMapLoading = false;
  late List<Widget> pages;
  late List<BarItem> barItems;
  late Future<bool> future;

  Future<bool> _loadViews() async {
    setState(() {
      _isMapLoading = true;
    });
    return _isMapLoading;
  }

  @override
  void initState() {
    controller = PageController(initialPage: selectedBottomBarIndex);
    future = _loadViews();
    userController.initUser();
    HelperMethods.instance.fetchUserProfile();
    pages = const [
      HomePage(),
      PatientPage(),
      ProfilePage(),
    ];
    barItems = [
      BarItem(
        icon: Icons.store_mall_directory_outlined,
        iconSize: 24.0,
        text: "Home",
        textSize: 18.0,
        color: BrandColors.kColorHomeView,
      ),
      BarItem(
        icon: LineAwesomeIcons.wheelchair,
        iconSize: 24.0,
        text: "Patient",
        textSize: 18.0,
        color: BrandColors.kColorPatientsView,
      ),
      BarItem(
        icon: LineAwesomeIcons.user_shield,
        iconSize: 24.0,
        text: "Profile",
        textSize: 18.0,
        color: BrandColors.kColorProfileView,
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: FutureBuilder<bool>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return PageView.builder(
                itemCount: 3,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  selectedBottomBarIndex = index;
                  setState(() {
                    selectedBottomBarIndex = index;
                  });
                },
                controller: controller,
                itemBuilder: (context, index) => pages[index],
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                semanticsLabel: "Please wait",
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Obx(
        () => AnimatedBottomBar(
          backgroundColor: !themeController.isLightTheme ? BrandColors.black : BrandColors.kColorBackground,
          onItemTap: (index) {
            controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut,
            );
          },
          barItems: barItems,
          currBarItem: selectedBottomBarIndex,
          animationDuration: const Duration(milliseconds: 150),
          elevation: 15,
        ),
      ),
    );
  }
}
