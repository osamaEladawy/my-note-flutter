import 'package:flutter/material.dart';

class CustomMyButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const CustomMyButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width - 40,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom( backgroundColor: const Color(0xff1B1464)),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          )),
    );
  }
}
