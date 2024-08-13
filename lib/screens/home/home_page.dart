import 'package:Intell_Home/screens/gas.dart';
import 'package:Intell_Home/widgets/light_control_widget.dart';
import 'package:Intell_Home/widgets/background.dart';
import 'package:Intell_Home/widgets/welcome_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/button.dart';
import '../../widgets/daylight_and_motion_detectors.dart';
import '../../widgets/simple_toast.dart';
import '../login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';
  bool isLoading = false;

  Future<void> getUserName() async {
    setState(() {
      isLoading = true;
    });
    try {
      final res = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      name = (res.data() as Map<String, dynamic>)['name'];
    } catch (e) {
      SimpleToast.show(msg: e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackGroundWidget(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leadingWidth: 200,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              color: Colors.black,
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false);
                } catch (e) {
                  SimpleToast.show(msg: e.toString());
                }
              },
              icon: const Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 5),
                  Text('Logout'),
                ],
              ),
            ),
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          WelcomeWidget(name: name),
                          const SizedBox(height: 30.0),
                          const LightControlWidget(),
                          const DaylightAndMotionDetectors(),
                          const SizedBox(height: 30.0),
                          ButtonWidget(
                            text : "Gas Data",
                             onTap : () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const GasWidget();
                        }
                          ));}
                          ),
                          const SizedBox(height: 100.0),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
