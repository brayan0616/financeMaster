import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {

  final String? label;
  final IconButton? suffixIcon;
  final Icon? icon;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final Color? backgroundColor;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key, 
    this.label,
    this.suffixIcon, 
    this.icon,
    this.backgroundColor,
    this.hintStyle,
    this.hint, 
    this.errorMessage, 
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged, 
    this.validator,
    this.controller
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
    );

    final focusBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colors.primary),
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
    );


    const borderRadius = Radius.circular(15);

    return Container(
      // padding: const EdgeInsets.only(bottom: 0, top: 15),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: const BorderRadius.only(topLeft: borderRadius, bottomLeft: borderRadius, bottomRight: borderRadius ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0,5)
          )
        ]
      ),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle( fontSize: 20, color: Colors.black54 ),
        decoration: InputDecoration(
          floatingLabelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          enabledBorder: border,
          focusedBorder: focusBorder,
          errorBorder: border.copyWith( borderSide: const BorderSide( color: Colors.transparent )),
          focusedErrorBorder: border.copyWith( borderSide: const BorderSide( color: Colors.transparent )),
          isDense: true,
          label: label != null ? Text(label!,style: textStyle.titleSmall!.copyWith(fontSize: 18),) : null,
          hintText: hint,
          hintStyle: hintStyle,
          errorText: errorMessage,
          focusColor: colors.primary,
          suffixIcon: suffixIcon,
          prefixIcon: icon

        ),
      ),
    );
  }
}
