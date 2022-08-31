import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:projectwork/index.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
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
                child: Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
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

                      Expanded(child: Container()),

                      /// buttons
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              // hide keyboard
                              FocusScope.of(context).unfocus();
                              // get the email and password from the text fields
                              final String email = _emailController.text.trim().toLowerCase();
                              final String password = _passwordController.text.toString();

                              if (!email.contains('@') || !email.contains('.')) {
                                showFlushAlert(context, "Invalid email address");
                                return;
                              }

                              if (password.length < 8) {
                                showFlushAlert(context, "Password must be at least 8 characters");
                                return;
                              }
                              //show please wait dialog
                              showLoading(context);
                              try {
                                await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                userController.initUser();
                                if (mounted) {}
                                //hide please wait dialog
                                Navigator.pop(context);
                                if (userController.isUserLoggedIn) {
                                  // debugPrint("user ${userController.currentFirebaseUser}");
                                  Navigator.pushNamedAndRemoveUntil(context, HomeScreen.id, (route) => false);
                                  HelperMethods.instance.fetchUserProfile();
                                }
                              } on FirebaseAuthException catch (e) {
                                //hide please wait dialog
                                Navigator.pop(context);
                                if (e.code == 'user-not-found') {
                                  showFlushAlert(context, 'No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  showFlushAlert(context, 'Wrong password provided for that user.');
                                }
                              } catch (e) {
                                showFlushAlert(context, "something went wrong, try again later");
                                debugPrint(e.toString());
                              }
                            },
                            child: const BrandButton(
                              title: "Log In",
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context, RegisterScreen.id, (route) => false);
                            },
                            child: const TransparentButton(
                              title: "Create Account",
                            ),
                          ),
                        ],
                      ),
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
