import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class LoginCard extends StatelessWidget {
  final double loginWidth;
  final double loginHeight;
  final double loginXOffset;
  final double loginYOffset;
  final double loginOpacity;
  final void Function() onTap;

  const LoginCard({
    Key? key,
    required this.loginWidth,
    required this.loginHeight,
    required this.loginXOffset,
    required this.loginYOffset,
    required this.loginOpacity,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(
        milliseconds: 1000,
      ),
      width: loginWidth,
      height: loginHeight,
      transform: Matrix4.translationValues(
        loginXOffset,
        loginYOffset,
        1,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        color: BrandColors.kSplashBackgroundColor.withOpacity(
          loginOpacity,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///input fields
            Column(
              children: const <Widget>[
                InputField(
                  title: "Email Address",
                  icon: Icons.email,
                ),
                SizedBox(height: 20.0),
                InputField(
                  title: "Password",
                  icon: Icons.vpn_key,
                ),
              ],
            ),

            /// buttons
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
                  },
                  child: const BrandButton(
                    title: "Log In",
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: onTap,
                  child: const TransparentButton(
                    title: "Create Account",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
