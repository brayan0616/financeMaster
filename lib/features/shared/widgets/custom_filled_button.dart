import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {

  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;
  final Widget? child;

  const CustomFilledButton({
    super.key, 
    this.onPressed, 
    required this.text, 
    this.buttonColor,
    this.child
  });

  @override
  Widget build(BuildContext context) {

    const radius = Radius.circular(10);
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: buttonColor,
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: radius,
          bottomRight: radius,
          topLeft: radius,
        )
      )),
        
  
      onPressed: onPressed, 
      child: child ?? Text(text),
    );
  }
}