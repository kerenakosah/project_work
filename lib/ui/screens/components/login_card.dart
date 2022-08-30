import 'package:dartz/dartz.dart' as dartz;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:projectwork/index.dart';

class LoginCard extends StatefulWidget {
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
  createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  // focus node
  late FocusNode currentFocus;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(
        milliseconds: 1000,
      ),
      width: widget.loginWidth,
      height: widget.loginHeight,
      transform: Matrix4.translationValues(
        widget.loginXOffset,
        widget.loginYOffset,
        1,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        color: BrandColors.kSplashBackgroundColor.withOpacity(
          widget.loginOpacity,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // input fields
            Column(
              children: <Widget>[
                InputField(
                  title: "Email Address",
                  icon: LineAwesomeIcons.envelope,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                const SizedBox(height: 20.0),
                InputField(
                  title: "Password",
                  icon: LineAwesomeIcons.key,
                  keyboardType: TextInputType.text,
                  obscureText: !_passwordVisible,
                  controller: _passwordController,
                  suffixIcon: _passwordVisible ? LineAwesomeIcons.eye_slash : LineAwesomeIcons.eye,
                  onTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ],
            ),

            /// buttons
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    currentFocus = FocusScope.of(context);
                    HelperFunctions.unFocus(context, currentFocus);
                    // get the email and password from the text fields
                    final String email = _emailController.text.trim().toLowerCase();
                    final String password = _passwordController.text.toString();

                    // validate form
                    if (email.isEmpty) {
                      // show snackBar
                      showCustomFlushBar(
                        context: context,
                        title: "Invalid email address",
                        messageText: "Please provide a valid email address",
                        icon: LineAwesomeIcons.exclamation_circle,
                        backgroundColor: !themeController.isLightTheme ? BrandColors.colorDarkBlue : BrandColors.colorDarkTheme,
                        iconColor: BrandColors.kColorWhiteAccent,
                        titleColor: BrandColors.kColorWhiteAccent,
                        messageColor: BrandColors.kColorWhiteAccent,
                      );
                      return;
                    }
                    if (!email.contains("@")) {
                      // show snackBar
                      showCustomFlushBar(
                        context: context,
                        title: "Invalid email address",
                        messageText: "Please provide a valid email address",
                        icon: LineAwesomeIcons.exclamation_circle,
                        backgroundColor: !themeController.isLightTheme ? BrandColors.colorDarkBlue : BrandColors.colorDarkTheme,
                        iconColor: BrandColors.kColorWhiteAccent,
                        titleColor: BrandColors.kColorWhiteAccent,
                        messageColor: BrandColors.kColorWhiteAccent,
                      );
                      return;
                    }

                    _loginUser(email: email, password: password);
                  },
                  child: const BrandButton(
                    title: "Log In",
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: widget.onTap,
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

  void _loginUser({
    required String email,
    required String password,
  }) async {
    // show progress dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => const ProgressDialog(status: "Please Wait..."),
    );

    try {
      dartz.Either<Failure, UserModel> response = await authRepo.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (mounted) {}
      if (response.isRight()) {
        response.fold(
          (error) {
            debugPrint("Error: $error");
            showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 400.0,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: BrandColors.kColorBackground,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CustomText(
                        text: "Info",
                        color: BrandColors.kErrorColor,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w900,
                      ),
                      BrandDivider(
                        height: 1.5,
                        color: BrandColors.kErrorColor,
                      ),
                      const SizedBox(height: 10.0),
                      CustomText(
                        text: "There was an error logging you in. try again later.",
                        color: BrandColors.kDark,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ],
                  ),
                );
              },
            );
          },
          (userModel) {
            Navigator.of(context).pop();
            Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
            userController.updateCurrentUserInfo(userModel);
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        // show snackBar
        showCustomFlushBar(
          context: context,
          title: "There was an error",
          messageText: "No user found with this email address",
          icon: LineAwesomeIcons.exclamation_circle,
          backgroundColor: BrandColors.colorDarkBlue,
          iconColor: BrandColors.kColorWhiteAccent,
          titleColor: BrandColors.kColorWhiteAccent,
          messageColor: BrandColors.kColorWhiteAccent,
        );
      } else if (e.code == 'wrong-password') {
        // show snackBar
        showCustomFlushBar(
          context: context,
          title: "There was an error",
          messageText: "Wrong password provided for that user.",
          icon: LineAwesomeIcons.exclamation_circle,
          backgroundColor: BrandColors.colorDarkBlue,
          iconColor: BrandColors.kColorWhiteAccent,
          titleColor: BrandColors.kColorWhiteAccent,
          messageColor: BrandColors.kColorWhiteAccent,
        );
      } else {
        // show snackBar
        showCustomFlushBar(
          context: context,
          title: "There was an error",
          messageText: "Something went wrong, try again later.",
          icon: LineAwesomeIcons.exclamation_circle,
          backgroundColor: BrandColors.colorDarkBlue,
          iconColor: BrandColors.kColorWhiteAccent,
          titleColor: BrandColors.kColorWhiteAccent,
          messageColor: BrandColors.kColorWhiteAccent,
        );
      }
    }
  }
}
