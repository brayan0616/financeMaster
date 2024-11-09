import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class IconHeader extends StatelessWidget {

  final IconData icon;
  final String title;
  final String subtitle;
  final Color? color1;
  final Color? color2;


  const IconHeader({
    super.key, 
    required this.icon,
    required this.title,
    required this.subtitle,
    this.color1,
    this.color2,
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;


    return Stack(
      children: [
        const _IconHeaderBackground(),
        Positioned(
          top: -10,
          left: -50,
          child: FaIcon(icon, size: 150, color: Colors.white.withOpacity(0.3)),
        ),

        Column(
          children: [
            const SizedBox( height: 80 , width: double.infinity,),
            Text(subtitle, style: textStyles.titleMedium?.copyWith( color: Colors.white.withOpacity(0.7), fontSize: 20 )),
            const SizedBox( height: 10 ),
            Text(title, style: textStyles.titleLarge?.copyWith( color: Colors.white )),
            const SizedBox( height: 10 ),
            FaIcon(icon, size: 80, color: Colors.white)
          ],
        )
          

      ],
    );
  }
}

class _IconHeaderBackground extends StatelessWidget {

  final Color? color1;
  final Color? color2;


  const _IconHeaderBackground({
    this.color1,
    this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        // color: Color(0xFFB0F2C2),
        borderRadius: const BorderRadius.only( bottomLeft: Radius.circular(80) ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color1 ?? const Color(0xFFB0F2C2),
               color2 ?? const Color(0xFF34A56F),
          ]
        )
      ),
    );
  }
}