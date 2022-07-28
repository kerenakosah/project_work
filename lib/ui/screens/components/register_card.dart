import 'package:flutter/material.dart';
import 'package:projectwork/index.dart';

class RegisterCard extends StatelessWidget {
  final double registerYOffset;
  final double registerHeight;
  final void Function() onTap;

  const RegisterCard({
    Key? key,
    required this.registerYOffset,
    required this.registerHeight,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(
        milliseconds: 1000,
      ),
      width: double.infinity,
      height: registerHeight,
      transform: Matrix4.translationValues(
        0,
        registerYOffset,
        1,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        color: BrandColors.kSplashBackgroundColor,
      ),
      padding: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //input fields
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

            // buttons
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, ProfilePage.id, (route) => false);
                  },
                  child: const BrandButton(
                    title: "Create Account",
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: onTap,
                  child: const TransparentButton(
                    title: "Log In",
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
