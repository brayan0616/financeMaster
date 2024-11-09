import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class InteresCompuestoScreen extends StatelessWidget {
  const InteresCompuestoScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB0F2C2),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 10, 115, 37)),
        centerTitle: true,
        title: Text('INTERES COMPUESTO', style: textStyle.titleMedium?.copyWith(color: const Color.fromARGB(255, 10, 115, 37), fontSize: 25, ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _CustomPainterView(),
            const SizedBox(height: 5),
            Text('Seleccione la incognita que desea \nencontrar', style: textStyle.titleMedium?.copyWith(fontSize: 20, color:const Color.fromARGB(255, 10, 115, 37) ),textAlign: TextAlign.center,),
            const SizedBox(height: 15),
            CardType(icon: Remix.money_dollar_circle_fill,title: 'Monto (M) o Valor Futuro (VF)',onTap: (){context.push('/monto-compuesto');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.exchange_funds_line,title: 'Monto por periodo',onTap: (){context.push('/monto-periodo');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.coins_fill,title: 'Capital',onTap: (){context.push('/capital-compuesto');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.discount_percent_fill,title: 'Tasa de interes',onTap: (){context.push('/tasa-compuesto');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.time_fill,title: 'Tiempo',onTap: (){context.push('/tiempo-compuesto');},),
            const SizedBox(height: 20),

            const SizedBox(height: 40),
          ],
        )
      )
      
    );
  }
}


class _CustomPainterView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      // color: const Color(0xFFB0F2C2).withOpacity(0.5),
      height: 580,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderHoverPainter(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Text('Es la acumulación de intereses que se generan en un período determinado de tiempo por un capital.', style: textStyles.titleSmall?.copyWith(fontSize: 18, ),textAlign: TextAlign.justify,),
              const SizedBox(height: 15,),
              Text.rich(
                textAlign: TextAlign.justify,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Valor presente o actual (VP): ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "Es el valor actual del crédito y se llama también capital inicial.",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),

                  ]
                )
              ),
              const SizedBox(height: 15,),
              Text.rich(
                textAlign: TextAlign.justify,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Interés o tasa de interés (I): ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "Es la tasa de interés que se cobrará o pagará dependiendo del caso.",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),

                  ]
                )
              ),
              const SizedBox(height: 15,),
              Text.rich(
                textAlign: TextAlign.justify,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Periodo (N): ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "Es el tiempo o plazo durante el cual se pagará el crédito.",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),

                  ]
                )
              ),
              const SizedBox(height: 15,),
              Text.rich(
                textAlign: TextAlign.justify,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Valor futuro (VF): ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "Es el valor total que se pagará al terminar el crédito y se llama también capital final.",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),

                  ]
                )
              ),
              const SizedBox(height: 15,),
              Text('Formula: ', style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),),

              const SizedBox(height: 15,),

              Math.tex(
                r'VF=VP\left(1+I\right)',
                textStyle: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
              ),

              const SizedBox(height: 15,),

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
    path.lineTo(0, size.height * 0.91);
    path.quadraticBezierTo(size.width * 0.25, size.height * 1.05 , size.width *0.5, size.height * 0.91);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.77 , size.width, size.height * 0.91);
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