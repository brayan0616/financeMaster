import 'package:flutter/material.dart';

class CardType extends StatelessWidget {

  final IconData icon;
  final String title;
  final Function()? onTap;

  const CardType({
    super.key,
    required this.icon,
    required this.title,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          color: const Color(0xFFB0F2C2).withOpacity(0.6),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            side: BorderSide(color: Color(0xFFB0F2C2), width: 1.5)
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 16),
            child: Row(
              children: [
                Icon(
                  icon, 
                  size: 30,
                  color: colors.primary,
                ),
                const SizedBox(width: 20),
                Text(
                  title,
                  style: textStyle.titleSmall?.copyWith(fontSize: 15, color: colors.primary, fontWeight: FontWeight.bold),

                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: colors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}