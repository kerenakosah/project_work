import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:projectwork/index.dart';

class LoginCard extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerStatefulWidget> createState() => LoginCardState();
}

class LoginCardState extends ConsumerState<LoginCard> {
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
    final themeController = ref.watch(themeProvider);
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
                  obscureText: !_passwordVisible,
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
                        backgroundColor: themeController.lightTheme ? BrandColors.colorDarkBlue : BrandColors.colorDarkTheme,
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
                        backgroundColor: themeController.lightTheme ? BrandColors.colorDarkBlue : BrandColors.colorDarkTheme,
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
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final User? _user = userCredential.user;
      UserModel? userModel = await userRepo.getUserDataFromFirebase(_user!.uid);
      // update the user logged in status
      ref.read(userProvider).initUser();
      // get the user model from the response
      ref.read(userProvider).updateCurrentUserInfo(userModel!);
      // check if user is logged in
      if (ref.read(userProvider).isUserLoggedIn) {
        // navigate to the home screen
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
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
      }
    }
  }
}
