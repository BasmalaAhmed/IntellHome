// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome $name',
                style: const TextStyle(
                    fontSize: 30,
                    fontFamily: "Archivo",
                    fontWeight: FontWeight.w600,
                    color: Color(0xff212C67)),
              ),
              const Divider(
                height: 15,
                thickness: 1,
                indent: 20,
                endIndent: 60,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(0xffD9D9D9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ]),
            child: Image.asset("images/User.png"))
      ],
    );
  }
}
