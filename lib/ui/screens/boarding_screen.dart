import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:projectwork/index.dart';

class BoardingScreen extends ConsumerStatefulWidget {
  // page id
  static const id = BrandStrings.boardingScreen;
  const BoardingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BoardingScreenState();
}

class BoardingScreenState extends ConsumerState<BoardingScreen> {
  int _pageState = 0;

  Color _backgroundColor = BrandColors.kSplashBackgroundColor;
  Color _textColor = BrandColors.kButtonColor;

  double _windowWidth = 0;
  double _windowHeight = 0;
  double _loginOpacity = 1;

  double _headingTop = 10;

  double _loginWidth = 0;
  double _loginHeight = 0;
  double _registerHeight = 0;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;

  @override
  Widget build(BuildContext context) {
    _windowWidth = MediaQuery.of(context).size.width;
    _windowHeight = MediaQuery.of(context).size.height;

    _loginHeight = _windowHeight - 270;
    _registerHeight = _windowHeight - 270;

    switch (_pageState) {
      case 0:
        _backgroundColor = BrandColors.kSplashBackgroundColor;
        _textColor = BrandColors.kButtonColor;
        _loginYOffset = _windowHeight;
        _loginXOffset = 0;
        _loginWidth = _windowWidth;
        _loginOpacity = 1;
        _registerYOffset = _windowHeight;
        _headingTop = 10;
        break;
      case 1:
        _backgroundColor = BrandColors.kPrimaryBackgroundColor;
        _textColor = BrandColors.kTextColor;
        _registerYOffset = _windowHeight;
        _loginXOffset = 0;
        _loginWidth = _windowWidth;
        _loginOpacity = 1;
        _loginYOffset = 270;
        _headingTop = 50;
        break;
      case 2:
        _backgroundColor = BrandColors.kPrimaryBackgroundColor;
        _textColor = BrandColors.kTextColor;
        _loginYOffset = 240;
        _loginXOffset = 25;
        _loginWidth = _windowWidth - 50;
        _loginOpacity = 0.4;
        _registerYOffset = 270;
        _headingTop = 20;
        break;
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SplashCard(
              backgroundColor: _backgroundColor,
              headingTop: _headingTop,
              textColor: _textColor,
              onTap: () {
                setState(() {
                  if (_pageState != 0) {
                    _pageState = 0;
                  } else {
                    _pageState = 1;
                  }
                });
              },
            ),
            LoginCard(
              loginWidth: _loginWidth,
              loginXOffset: _loginXOffset,
              loginYOffset: _loginYOffset,
              loginOpacity: _loginOpacity,
              loginHeight: _loginHeight,
              onTap: () {
                setState(() {
                  _pageState = 2;
                });
              },
            ),
            RegisterCard(
              registerHeight: _registerHeight,
              registerYOffset: _registerYOffset,
              onTap: () {
                setState(() {
                  _pageState = 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
