import 'package:flutter/material.dart';
import 'package:Intell_Home/screens/register_page.dart';
import 'package:Intell_Home/widgets/background.dart';
import 'package:Intell_Home/widgets/logo.dart';
import 'package:Intell_Home/widgets/button.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.center, children: [
      const BackGroundWidget(),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Spacer(),
        Image.asset('images/wifi.png'),
        const Padding(
            padding: EdgeInsets.only(left: 30),
            child: LogoWidget(
              text: "IntellHome",
              color: Color(0xff112D4E),
            )),
        const SizedBox(
          height: 225,
        ),
        ButtonWidget(
          text: "Get Started",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Register(),
              ),
            );
          },
        ),
        const SizedBox(
          height: 70,
        ),
      ])
    ]));
  }
}
