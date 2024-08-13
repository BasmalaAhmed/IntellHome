// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 8, horizontal: 10)),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
            foregroundColor:
                WidgetStateProperty.all<Color>(const Color(0xffFFFFFF)),
            backgroundColor:
                WidgetStateProperty.all<Color>(const Color(0xff112D4E)),
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.focused) ||
                    states.contains(WidgetState.pressed)) {
                  return const Color(0x112d4ef2).withOpacity(0.12);
                }
                return null;
              },
            ),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
                fontFamily: "Archivo",
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
        ),
      ),
    );
  }
}
