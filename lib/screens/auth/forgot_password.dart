import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:user_zeebe_app/screens/auth/login.dart';
import 'package:user_zeebe_app/screens/auth/register.dart';
import 'package:user_zeebe_app/services/assets_manager.dart';
import 'package:user_zeebe_app/widgets/app_name_text.dart';
// Import the assets manager

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgotPasswordScreen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordScreen> {
  TextEditingController mailcontroller = new TextEditingController();

  String email = "";

  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Password Reset Email has been sent !",
        style: TextStyle(fontSize: 18.0),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "No user found for that email.",
          style: TextStyle(fontSize: 18.0),
        )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppNameTextWidget(
          fontSize: 22,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: const Text(
                "Password Recovery",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Image.asset(
              AssetsManager.fpass,
              width: size.width * 0.6,
              height: size.width * 0.6,
            ),
            Expanded(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white70, width: 2.0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          controller: mailcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(
                              IconlyLight.message,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = mailcontroller.text;
                            });
                            resetPassword();
                          }
                        },
                        child: Container(
                          width: 50,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                            child: Text(
                              "Send Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: const Text(
                              "Create",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 19, 99, 137),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/*
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:user_zeebe_app/consts/my_validators.dart';
import 'package:user_zeebe_app/services/assets_manager.dart';
import 'package:user_zeebe_app/widgets/app_name_text.dart';
import 'package:user_zeebe_app/widgets/subtitles_text.dart';
import 'package:user_zeebe_app/widgets/titles_text.dart';



class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgotPasswordScreen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final TextEditingController _emailController;
  late final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _emailController.dispose();
    }
    super.dispose();
  }

  Future<void> _forgetPassFCT() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppNameTextWidget(
          fontSize: 22,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: ListView(
            // shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            physics: const BouncingScrollPhysics(),
            children: [
              // Section 1 - Header
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                AssetsManager.fpass,
                width: size.width * 0.6,
                height: size.width * 0.6,
              ),
              const SizedBox(
                height: 10,
              ),
              const TitleTextWidget(
                label: 'Forgot password',
                fontSize: 22,
              ),
              const SubtitleTextWidget(
                label:
                    'Please enter the email address you\'d like your password reset information sent to',
                fontSize: 14,
              ),
              const SizedBox(
                height: 40,
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'youremail@email.com',
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(12),
                          child: const Icon(IconlyLight.message),
                        ),
                        filled: true,
                      ),
                      validator: (value) {
                        return MyValidators.emailValidator(value);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    // backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  icon: const Icon(IconlyBold.send),
                  label: const Text(
                    "Request link",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () async {
                    _forgetPassFCT();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/