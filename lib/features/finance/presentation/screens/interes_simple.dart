import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class InteresSimpleScreen extends StatelessWidget {
  const InteresSimpleScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB0F2C2),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 10, 115, 37)),
        centerTitle: true,
        title: Text('INTERES SIMPLE', style: textStyle.titleMedium?.copyWith(color: const Color.fromARGB(255, 10, 115, 37), fontSize: 25, ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomPainterView(),
            const SizedBox(height: 5),
            Text('Seleccione la incognita que desea \nencontrar', style: textStyle.titleMedium?.copyWith(fontSize: 20, color:const Color.fromARGB(255, 10, 115, 37) ),textAlign: TextAlign.center,),
            const SizedBox(height: 15),
            CardType(icon: Remix.money_dollar_circle_fill,title: 'Monto (M) o Valor Futuro (VF)',onTap: (){context.push('/monto-simple');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.exchange_funds_line,title: 'Interes',onTap: (){context.push('/interes-simple-page');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.coins_fill,title: 'Capital',onTap: (){context.push('/capital-simple');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.discount_percent_fill,title: 'Tasa de interes',onTap: (){context.push('/tasa-interes-simple');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.time_fill,title: 'Tiempo',onTap: (){context.push('/tiempo-simple');},),
            const SizedBox(height: 20),

            const SizedBox(height: 40),
          ],
        )
      )
      
    );
  }
}

class CustomPainterView extends StatelessWidget {
  const CustomPainterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      // color: const Color(0xFFB0F2C2).withOpacity(0.5),
      height: 520,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderHoverPainter(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text.rich(
                textAlign: TextAlign.justify,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'El Interes',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: " es el costo que se paga por el uso del dinero ajeno en un tiempo t, y puede expresarse en unidades monetarias I" 
                            " (pesos, dólares, euros, etc.) o en porcentaje (%), también llamada",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),
                    TextSpan(
                      text: ' tasa interés i.',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                  ]
                )
              ),
              Text.rich(
                textAlign: TextAlign.justify,
                TextSpan(
                  children: [
                    TextSpan(
                      text: '\nEl interés simple',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: ", es el que se cobra sobre el principal,",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),
                    TextSpan(
                      text: ' capital C',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: " o Valor Presente (VP) por un tiempo t, expresado en años, así tenemos:",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),
                  ]
                )
              ),

              const SizedBox(height: 10,),

              Math.tex(
                r'I\:=\:Cit',
                textStyle: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
              ),

              Text.rich(
                textAlign: TextAlign.justify,
                TextSpan(
                  children: [
                    TextSpan(
                      text: '\nEl',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),
                    TextSpan(
                      text: " monto M",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: ' al final del periodo o Valor Futuro (VF) se obtiene entonces con la formula:',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),
                  ]
                )
              ),

              const SizedBox(height: 10,),

              Math.tex(
                r'M\:=\:C\:\left(1\:+\:it\right)\:\:ó\:\:VF\:=\:VP\:\left(1\:+\:it\right)',
                textStyle: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
              ),

            ],
          ),
        ),
      ),
    );
  }
}





class _HeaderHoverPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();

    lapiz.color = const Color(0xFFB0F2C2);
    lapiz.style = PaintingStyle.fill;
    // lapiz.style = PaintingStyle.stroke;
    lapiz.strokeWidth = 2;

    final path = Path();

    //*dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.85);
    path.quadraticBezierTo(size.width * 0.25, size.height * 1 , size.width *0.5, size.height * 0.85);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.70 , size.width, size.height * 0.90);
    path.lineTo(size.width,0);
    path.lineTo(0,0);
    // path.quadraticBezierTo(size.width * 0.5, size.height * 0.4, size.width, size.height * 0.35);

    canvas.drawPath(path, lapiz);
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    
    return true;
  }

}