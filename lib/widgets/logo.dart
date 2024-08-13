import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget{
  final String text;
  final Color? color;
  const LogoWidget ({
    super.key,
    required this.text,
    this.color,
   });
   
     @override
     Widget build(BuildContext context) {
      return Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily:"Inter",
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    );
     }
}