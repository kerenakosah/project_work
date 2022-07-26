import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class HomeScreen extends StatefulWidget {
  // page id
  static const String id = BrandStrings.homeScreen;
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const <Widget>[],
      ),
    );
  }
}
