import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:projectwork/index.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "register_screen";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColors.kColorWhiteAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IntroText(textColor: BrandColors.kColorText),
              const SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: BrandColors.kSplashBackgroundColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                      offset: const Offset(
                        0.0,
                        1.4,
                      ),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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

                      Expanded(child: Container()),
                      // buttons
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              // hide keyboard
                              FocusScope.of(context).unfocus();

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
                              if (password.length < 8) {
                                // show snackBar
                                showCustomFlushBar(
                                  context: context,
                                  title: "Weak Password",
                                  messageText: "Password must be at least 8 characters",
                                  icon: LineAwesomeIcons.exclamation_circle,
                                  backgroundColor: !themeController.isLightTheme ? BrandColors.colorDarkBlue : BrandColors.colorDarkTheme,
                                  iconColor: BrandColors.kColorWhiteAccent,
                                  titleColor: BrandColors.kColorWhiteAccent,
                                  messageColor: BrandColors.kColorWhiteAccent,
                                );
                                return;
                              }

                              showLoading(context);

                              try {
                                UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                if (mounted) {}
                                //hide please wait dialog
                                Navigator.pop(context);
                                debugPrint(credential.toString());
                                userController.initUser();
                                if (credential.user != null) {
                                  Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
                                  HelperMethods.instance.postData(
                                    firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    phoneNumber: phoneNumber,
                                  );
                                  // fetch the user data from the database
                                  HelperMethods.instance.fetchUserProfile();
                                }
                              } on FirebaseAuthException catch (e) {
                                //hide please wait dialog
                                Navigator.pop(context);
                                if (e.code == 'weak-password') {
                                  showFlushAlert(context, 'The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  showFlushAlert(context, 'The account already exists for that email.');
                                }
                              } catch (e) {
                                showFlushAlert(context, "something went wrong, try again later");
                                debugPrint(e.toString());
                              }
                            },
                            child: const BrandButton(
                              title: "Create Account",
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (route) => false);
                            },
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
            ],
          ),
        ),
      ),
    );
  }
}
