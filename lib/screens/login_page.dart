import 'dart:developer';

import 'package:Intell_Home/screens/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Intell_Home/screens/forgot_password_page.dart';
import 'package:Intell_Home/screens/register_page.dart';
import 'package:Intell_Home/widgets/background.dart';
import 'package:Intell_Home/widgets/button.dart';
import 'package:Intell_Home/widgets/simple_toast.dart';
import 'package:Intell_Home/widgets/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const HomePage();
          },
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      log(e.code);
      switch (e.code) {
        case 'email-already-in-use':
          return SimpleToast.show(msg: 'البريد الالكتروني مستخدم بالفعل');
        case 'invalid-email':
          return SimpleToast.show(msg: 'البريد الالكتروني خاطيء');
        case 'weak-password':
          return SimpleToast.show(msg: 'كلمة المرور ضعيفة');
        case 'invalid-credential':
          return SimpleToast.show(
              msg: 'هناك خطأ في البريد الالكتروني او كلمة المرور');
        case 'too-many-requests':
          return SimpleToast.show(msg: 'الرجاء المحاولة في وقت لاحق');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const BackGroundWidget(),
        ListView(children: [
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 100, bottom: 30),
                  child: Text(
                    "Welcome Back!",
                    style: TextStyle(
                        color: Color(0xff1C3756),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    "Login to your existing account",
                    style: TextStyle(
                        color: Color(0xff1C3756),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      TextFieldWidget(
                          controller: emailController,
                          text: "Enter Your Email",
                          preicon: Icons.email_rounded),
                      const SizedBox(
                        height: 23,
                      ),
                      TextFieldWidget(
                          controller: passwordController,
                          text: "Enter Password",
                          preicon: Icons.person_2_rounded,
                          sufficon: Icons.remove_red_eye_rounded),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all<Color>(
                          const Color(0xff112D4E)),
                      overlayColor: WidgetStateProperty.all<Color>(
                          const Color(0xff112D4E).withOpacity(0.12))),
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ForgotPassword();
                    }));
                  },
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(fontFamily: "Inter", fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff112D4E),
                    ),
                  )
                else
                  ButtonWidget(
                    text: "Login",
                    onTap: login,
                  ),
                const SizedBox(
                  height: 35,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Color(0xff112D4E),
                          fontFamily: "Inter",
                          fontSize: 18),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          foregroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xff112D4E)),
                          overlayColor: WidgetStateProperty.all<Color>(
                              const Color(0xff112D4E).withOpacity(0.12))),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const Register();
                        }));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ]),
    );
  }
}
