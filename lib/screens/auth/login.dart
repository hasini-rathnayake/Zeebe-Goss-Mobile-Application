import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_zeebe_app/consts/my_validators.dart';
import 'package:user_zeebe_app/root_screen.dart';
import 'package:user_zeebe_app/screens/auth/forgot_password.dart';
import 'package:user_zeebe_app/screens/auth/register.dart';
import 'package:user_zeebe_app/screens/loading_manager.dart';
import 'package:user_zeebe_app/services/my_app_methods.dart';
import 'package:user_zeebe_app/widgets/app_name_text.dart';

import 'package:user_zeebe_app/widgets/subtitles_text.dart';
import 'package:user_zeebe_app/widgets/titles_text.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // Focus Nodes
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
      _passwordController.dispose();
      // Focus Nodes
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _loginFct() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      try {
        setState(() {
          _isLoading = true;
        });

        await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Fluttertoast.showToast(
          msg: "Login Successful",
          textColor: Colors.white,
        );
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, RootScreen.routeName);
      } on FirebaseException catch (error) {
        await MyAppMethods.showErrorOrWarningDialog(
          context: context,
          subtitle: error.message.toString(),
          fct: () {},
        );
      } catch (error) {
        await MyAppMethods.showErrorOrWarningDialog(
          context: context,
          subtitle: error.toString(),
          fct: () {},
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: LoadingManager(
          isLoading: _isLoading,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color.fromARGB(255, 218, 140, 227),
                      Color.fromARGB(255, 235, 208, 231),
                    ])),
              ),
              Container(
                color: Colors.black.withOpacity(
                    0.0), // Optional: Add a dark overlay for better contrast
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        const AppNameTextWidget(
                          fontSize: 30,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: TitleTextWidget(
                            label: "",
                            color: Color.fromARGB(255, 96, 0, 108),
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: _emailController,
                                focusNode: _emailFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: "Email address",
                                  prefixIcon: Icon(
                                    IconlyLight.message,
                                  ),
                                ),
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                },
                                validator: (value) {
                                  return MyValidators.emailValidator(value);
                                },
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              TextFormField(
                                obscureText: obscureText,
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  hintText: "***********",
                                  prefixIcon: const Icon(
                                    IconlyLight.lock,
                                  ),
                                ),
                                onFieldSubmitted: (value) async {
                                  await _loginFct();
                                },
                                validator: (value) {
                                  return MyValidators.passwordValidator(value);
                                },
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      ForgotPasswordScreen.routeName,
                                    );
                                  },
                                  child: const SubtitleTextWidget(
                                    label: "Forgot password?",
                                    color: Color.fromARGB(255, 96, 0, 108),
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    textDecoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(12.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ),
                                    ),
                                  ),
                                  icon: const Icon(Icons.login),
                                  label: const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await _loginFct();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              SubtitleTextWidget(
                                color: Color.fromARGB(255, 96, 0, 108),
                                fontWeight: FontWeight.bold,
                                label: "Or".toUpperCase(),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(10.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.0,
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "Guest",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context)
                                          .pushNamed(RootScreen.routeName);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SubtitleTextWidget(
                                    label: "New here?",
                                    fontWeight: FontWeight.bold,
                                  ),
                                  TextButton(
                                    child: const SubtitleTextWidget(
                                      label: "Register",
                                      color: Color.fromARGB(255, 96, 0, 108),
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                      textDecoration: TextDecoration.underline,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(RegisterScreen.routeName);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
