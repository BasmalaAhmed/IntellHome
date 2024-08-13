import 'package:flutter/material.dart';


class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.title,
    required this.image,
    required this.color,
  });
  final String title;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 159,
      height: 195,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              image,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xffE3E3E3),
                borderRadius: BorderRadius.circular(20),),
                    height: 55.53,
                    width: 123,
            child: Center(
                child: Text(
              title,
              style:  TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color ,
              ),
            )),
          )
        ],
      ),
    );
  }
}
