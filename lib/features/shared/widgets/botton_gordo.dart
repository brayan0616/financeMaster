import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotonGordo extends StatelessWidget {

  final IconData icon;
  final String texto;
  final Color? color1;
  final Color? color2;
  final Function()? onPress;
  final double? rightPosition;
  final double? bottomPosition;


  const BotonGordo({
    super.key,
    required this.icon,
    required this.texto,
    this.color1, 
    this.color2,
    required this.onPress,
    this.rightPosition,
    this.bottomPosition,
    });

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onPress,
      child: Stack(
        children: [
          _BotonGordoBackground(
            icon: icon,
            color1: color1,
            color2: color2,
            bottomPosition: bottomPosition,
            rightPosition: rightPosition,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 140, width: 40),
              FaIcon(icon, size: 40, color: Colors.white),
              const SizedBox(width: 20),
              Expanded(child: Text(texto, style: textStyle.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),)),
              const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
              const SizedBox(width: 40),
            ],
          ),
        ],
      ),
    );
  }
}

class _BotonGordoBackground extends StatelessWidget {

  final IconData icon;
  final double? rightPosition;
  final double? bottomPosition;
  final Color? color1;
  final Color? color2;

  const _BotonGordoBackground({
    required this.icon,
    this.rightPosition,
    this.bottomPosition,
    this.color1,
    this.color2,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(4, 6),
            blurRadius: 10,
          ),
        ],
        gradient: LinearGradient(
          colors: [
             color1 ?? const Color(0xFFB0F2C2),
             color2 ?? const Color(0xFF34A56F),
          ],
        ),
      ),
    
    
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
              right: rightPosition ?? -20,
              bottom: bottomPosition ?? -20,
              child: Icon(icon , size: 150, color: Colors.white.withOpacity(0.2)),
            ),
          ],
        ),
      ),
    );
  }
}