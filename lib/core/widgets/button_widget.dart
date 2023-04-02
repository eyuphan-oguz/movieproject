import 'package:flutter/material.dart';
import 'package:movieproject/product/constant/colors.dart';


class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.onPressed, required this.buttonText, required this.size, required this.backgroundColor});
  final Function() onPressed;
  final String buttonText;
  final Size size;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width*1,
      height: size.height*0.05,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: backgroundColor,elevation: 0.2),
        child: Text(buttonText),
      ),
    );
  }
}