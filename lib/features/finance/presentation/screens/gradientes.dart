import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class GradientesScreen extends StatelessWidget {
  const GradientesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB0F2C2),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 10, 115, 37)),
        centerTitle: true,
        title: Text('GRADIENTES', style: textStyle.titleMedium?.copyWith(color: const Color.fromARGB(255, 10, 115, 37), fontSize: 25, ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _CustomPainterView(),
            const SizedBox(height: 5),
            Text('Seleccione el tipo de gradiente a \nresolver', style: textStyle.titleMedium?.copyWith(fontSize: 20, color:const Color.fromARGB(255, 10, 115, 37) ),textAlign: TextAlign.center,),
            const SizedBox(height: 15),
            CardType(icon: Remix.percent_line,title: 'Aritmetico o Lineal',onTap: (){context.push('/aritmetico');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.nft_fill,title: 'Geometrico',onTap: (){context.push('/geometrico');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.funds_line,title: 'Escalonado',onTap: (){context.push('/escalonado');},),

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
      height: 480,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderHoverPainter(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 15),
              
              Text.rich(
                textAlign: TextAlign.justify,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Gradientes o Series Variables ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "consisten en una serie de pagos periodicos que aumentan o disminuyen en cada periodo, con relación al pago anterior, es decir es una forma de pago en el que las cuotas varían.",
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
                      text: 'Condiciones ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "para considerar una serie de pagos como gradiente, deben ser las siguentes:\n",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),
                    TextSpan(
                      text: "\n- Deben tener una ley de conformación \n- Los pagos deben ser periodicos \n- Misma tasa de interés a todos los pagos \n- Número de periodos debe ser igual \n   al número de pagos",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),

                  ]
                )
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