import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:projectwork/index.dart';

class HomeScreen extends ConsumerStatefulWidget {
  // page id
  static const String id = BrandStrings.homeScreen;
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  late PageController _controller;
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
    _controller = PageController(initialPage: selectedBottomBarIndex);
    future = _loadViews();
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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // theme controller
    final themeController = ref.watch(themeProvider);

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
                controller: _controller,
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
      bottomNavigationBar: AnimatedBottomBar(
        backgroundColor: themeController.darkTheme ? BrandColors.kDark : BrandColors.kColorBackground,
        onItemTap: (index) {
          _controller.animateToPage(
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
    );
  }
}
