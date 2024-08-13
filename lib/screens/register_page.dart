import 'package:Intell_Home/screens/home/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Intell_Home/screens/login_page.dart';
import 'package:Intell_Home/widgets/background.dart';
import 'package:Intell_Home/widgets/button.dart';
import 'package:Intell_Home/widgets/text_field.dart';

import '../widgets/simple_toast.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });
    try {
      final userCred =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user!.uid)
          .set(
        {'name': nameController.text},
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
      switch (e.code) {
        case 'email-already-in-use':
          return SimpleToast.show(msg: 'البريد الالكتروني مستخدم بالفعل');
        case 'invalid-email':
          return SimpleToast.show(msg: 'البريد الالكتروني خاطيء');
        case 'weak-password':
          return SimpleToast.show(msg: 'كلمة المرور ضعيفة');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
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
                    "Create an account",
                    style: TextStyle(
                        color: Color(0xff1C3756),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        controller: nameController,
                        text: "Enter Your Full Name",
                        preicon: Icons.person_2_rounded,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFieldWidget(
                          controller: emailController,
                          text: "Enter Your Email",
                          preicon: Icons.email_rounded),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFieldWidget(
                          controller: passwordController,
                          text: "Enter Password",
                          preicon: Icons.password_rounded,
                          sufficon: Icons.remove_red_eye_rounded),
                      // SizedBox(
                      //   height: 25,
                      // ),
                      // TextFieldWidget(
                      //     text: "Confirm Password",
                      //     preicon: Icons.password_rounded,
                      //     sufficon: Icons.remove_red_eye_rounded),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
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
                    text: "Register",
                    onTap: register,
                  ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
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
                          return const Login();
                        }));
                      },
                      child: const Text(
                        'Sign in',
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
