import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Intell_Home/widgets/background.dart';
import 'package:Intell_Home/widgets/simple_toast.dart';
import 'package:Intell_Home/widgets/text_field.dart';
import 'package:Intell_Home/widgets/button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff112D4E),
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(children: [
          const BackGroundWidget(),
          ListView(
            children: [
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 100, bottom: 30),
                      child: Text(
                        "Forgot Your Password?",
                        style: TextStyle(
                            color: Color(0xff1C3756),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Image.asset('images/forget.png'),
                    const Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      child: Text(
                        "Enter the email associated with your account \n      to send a link to reset your password.",
                        style: TextStyle(
                            color: Color(0xff1C3756),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFieldWidget(
                          controller: emailController,
                          text: "Enter Your Email",
                          preicon: Icons.email_rounded),
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ButtonWidget(
                        text: "Send Link",
                        onTap: () async {
                          if (!formKey.currentState!.validate()) return;
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                                email: emailController.text);
                            emailController.clear();
                            SimpleToast.show(
                              msg:
                                  'تم ارسال رابط الى بريدك الالكتروني لتغيير كلمة المرور',
                              state: ToastStates.success,
                            );
                          } on FirebaseAuthException catch (err) {
                            SimpleToast.show(
                              msg: err.message.toString(),
                            );
                            throw Exception(err.message.toString());
                          } catch (err) {
                            SimpleToast.show(
                              msg: err.toString(),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
            ],
          )
        ]));
  }
}
