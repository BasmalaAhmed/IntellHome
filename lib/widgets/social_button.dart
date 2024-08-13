import 'package:flutter/material.dart';

class SocialButtonWidget extends StatelessWidget{
  final String text;
  final IconData icon;
  const SocialButtonWidget ({
    super.key,
    required this.text,
    required this.icon,
   });
   
     @override
     Widget build(BuildContext context) {
      return ElevatedButton(  
                style: ButtonStyle(
                  padding:const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 8 , horizontal: 20)),
                  foregroundColor: WidgetStateProperty.all<Color>(const Color(0xff112D4E)),
                  backgroundColor: WidgetStateProperty.all<Color>(const Color(0xffFFFFFF)),
                  overlayColor: WidgetStateProperty.resolveWith<Color?>(
                   (Set<WidgetState> states) {
                    if (states.contains(WidgetState.focused) ||
                  states.contains(WidgetState.pressed)) {
                      return const Color(0x00112d4e).withOpacity(0.12);
                    }
                    return null; 
      },
    ),
                ), 
                onPressed: () {
                  /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return widget;
                  }));*/
                },  
                child:  Row(
                  children: [
                    Icon(
                      icon, 
                      size: 35,
                    )
                    ,
                    const SizedBox(width: 10,),
                    Text(
                      text,
                       style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 20),),
                  ],
                ),  
              );
     }
}