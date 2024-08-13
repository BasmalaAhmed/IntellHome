import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String text;
  final IconData preicon;
  final TextEditingController? controller;
  final IconData? sufficon;
  const TextFieldWidget({
    super.key,
    required this.text,
    required this.preicon,
    this.sufficon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value!.isEmpty ? "Please Enter this field" : null,
      decoration: InputDecoration(
        prefixIcon: Icon(
          preicon,
        ),
        suffixIcon: Icon(sufficon),
        hintText: text,
        hintStyle: const TextStyle(color: Color(0xff112D4E)),
        filled: true,
        fillColor: const Color(0xffFFFCFC),
        contentPadding: const EdgeInsets.all(13),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
