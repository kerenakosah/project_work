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
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //input fields
              Column(
                children: const <Widget>[
                  InputField(
                    title: "First Name",
                    icon: Icons.person,
                  ),
                  SizedBox(height: 20.0),
                  InputField(
                    title: "Last Name",
                    icon: Icons.person,
                  ),
                  SizedBox(height: 20.0),
                  InputField(
                    title: "Email Address",
                    icon: Icons.email,
                  ),
                  SizedBox(height: 20.0),
                  InputField(
                    title: "Phone Number",
                    icon: Icons.call,
                  ),
                  SizedBox(height: 20.0),
                  InputField(
                    title: "Password",
                    icon: Icons.vpn_key,
                  ),
                  SizedBox(height: 20.0),
                ],
              ),

              const SizedBox(height: 20.0),
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
      ),
    );
  }
}
