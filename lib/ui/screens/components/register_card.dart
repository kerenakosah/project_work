import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:projectwork/index.dart';

class RegisterCard extends ConsumerStatefulWidget {
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
  ConsumerState<ConsumerStatefulWidget> createState() => RegisterCardState();
}

class RegisterCardState extends ConsumerState<RegisterCard> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

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
      width: double.infinity,
      height: widget.registerHeight,
      transform: Matrix4.translationValues(
        0,
        widget.registerYOffset,
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
                children: <Widget>[
                  InputField(
                    title: "First Name",
                    icon: LineAwesomeIcons.user,
                    controller: _firstNameController,
                  ),
                  const SizedBox(height: 20.0),
                  InputField(
                    title: "Last Name",
                    icon: LineAwesomeIcons.user,
                    controller: _lastNameController,
                  ),
                  const SizedBox(height: 20.0),
                  InputField(
                    title: "Email Address",
                    icon: LineAwesomeIcons.envelope,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20.0),
                  InputField(
                    title: "Phone Number",
                    icon: LineAwesomeIcons.phone,
                    keyboardType: TextInputType.number,
                    controller: _phoneNumberController,
                  ),
                  const SizedBox(height: 20.0),
                  InputField(
                    title: "Password",
                    icon: LineAwesomeIcons.key,
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    suffixIcon: _passwordVisible ? LineAwesomeIcons.eye_slash : LineAwesomeIcons.eye,
                    onTap: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),

              const SizedBox(height: 100.0),
              // buttons
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      currentFocus = FocusScope.of(context);
                      HelperFunctions.unFocus(context, currentFocus);

                      // get all the values from the text edit controllers
                      final String firstName = _firstNameController.text.trim();
                      final String lastName = _lastNameController.text.trim();
                      final String email = _emailController.text.trim().toLowerCase();
                      final String phoneNumber = _phoneNumberController.text.trim();
                      final String password = _passwordController.text.trim().toString();

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
                      if (password.length < 8) {
                        // show snackBar
                        showCustomFlushBar(
                          context: context,
                          title: "Weak Password",
                          messageText: "Password must be at least 8 characters",
                          icon: LineAwesomeIcons.exclamation_circle,
                          backgroundColor: themeController.lightTheme ? BrandColors.colorDarkBlue : BrandColors.colorDarkTheme,
                          iconColor: BrandColors.kColorWhiteAccent,
                          titleColor: BrandColors.kColorWhiteAccent,
                          messageColor: BrandColors.kColorWhiteAccent,
                        );
                        return;
                      }

                      _registerUser(
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        phoneNumber: phoneNumber,
                        password: password,
                      );
                    },
                    child: const BrandButton(
                      title: "Create Account",
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const TransparentButton(
                      title: "Log In",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  void _registerUser({
    required String firstName,
    required String lastName,
    required String password,
    required String email,
    required String phoneNumber,
  }) async {
    // show progress dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => const ProgressDialog(status: "Please Wait..."),
    );
    // register a new firebase user with email and password
    Either<Failure, UserModel> response = await authRepo.registerWithEmailAndPassword(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );
    // if the response is a success, then navigate to the home screen
    if (response.isRight()) {
      // update the user logged in status
      ref.read(userProvider).initUser();

      // get the UserModel from the response
      response.fold(
        (exception) => debugPrint(exception.message.toString()),
        // update current user info
        (userModel) => ref.read(userProvider).updateCurrentUserInfo(userModel),
      );
      // check if user is logged in
      if (ref.read(userProvider).isUserLoggedIn) {
        // navigate to the home screen
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
      }
    }
    return;
  }
}
