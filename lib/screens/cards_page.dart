// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:Intell_Home/screens/gas.dart';
import 'package:Intell_Home/widgets/light_control_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Intell_Home/screens/login_page.dart';
import 'package:Intell_Home/widgets/simple_toast.dart';
import 'package:Intell_Home/widgets/background.dart';
import 'package:Intell_Home/widgets/Cards.dart';

import '../widgets/welcome_widget.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
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
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff112D4E),
              ),
            )
          : Stack(
              children: [
                const BackGroundWidget(),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40, left: 325),
                        child: IconButton(
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                  (route) => false);
                            } catch (e) {
                              SimpleToast.show(msg: e.toString());
                            }
                          },
                          icon: const Icon(Icons.logout),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: WelcomeWidget(name: name),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 20),
                        child: Container(
                          width: 270,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xffFEBF10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ]),
                          child: const Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 15.0, left: 15),
                                    child: Text(
                                      "28°C",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontFamily: "Archivo",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff212C67)),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 15.0, right: 15),
                                    child: Icon(
                                      Icons.wb_sunny_outlined,
                                      color: Color(0xff212C67),
                                      size: 35,
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                height: 30,
                                thickness: 1,
                                indent: 20,
                                endIndent: 20,
                                color: Colors.black,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Humidity",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Archivo",
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff212C67)),
                                        ),
                                        Text(
                                          "68%",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Archivo",
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff212C67)),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Text(
                                          "Precipitation",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Archivo",
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff212C67)),
                                        ),
                                        Text(
                                          "34%",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Archivo",
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff212C67)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 50,
                        thickness: 1,
                        indent: 120,
                        endIndent: 120,
                        color: Colors.black,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                              width: 117,
                              height: 56,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: const Color(0xffD7CBCB),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]),
                              child: const Center(
                                child: Text(
                                  "Devices",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontFamily: "Archivo",
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff112D4E)),
                                  textAlign: TextAlign.center,
                                ),
                              ))),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LightControlWidget(),
                                      ));
                                },
                                child: const CardWidget(
                                  title: "Lights",
                                  color: Color(0xff254974),
                                  image: "images/Group25Lights.jpg",
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const GasWidget(),
                                      ));
                                },
                                child: const CardWidget(
                                  title: "Gas",
                                  color: Color(0xffF25656),
                                  image: "images/GasIndustryGAS.jpg",
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
