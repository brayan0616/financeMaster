import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class AmortizacionScreen extends StatelessWidget {
  const AmortizacionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB0F2C2),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 10, 115, 37)),
        centerTitle: true,
        title: Text('AMORTIZACION Y CAP', style: textStyle.titleMedium?.copyWith(color: const Color.fromARGB(255, 10, 115, 37), fontSize: 25, ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _CustomPainterView(),
            const SizedBox(height: 5),
            Text('Seleccione la incognita que desea \nencontrar', style: textStyle.titleMedium?.copyWith(fontSize: 20, color:const Color.fromARGB(255, 10, 115, 37) ),textAlign: TextAlign.center,),
            const SizedBox(height: 15),
            CardType(icon: Remix.money_dollar_circle_fill,title: 'Capitalizacion Simple',onTap: (){context.push('/capitalizacion-simple');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.money_pound_circle_line,title: 'Capitalizacion Compuesta',onTap: (){context.push('/capitalizacion-compuesta');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.coins_fill,title: 'Sistrema Americano',onTap: (){context.push('/sistema-americano');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.money_pound_circle_line,title: 'Sistema Frances',onTap: (){context.push('/sistema-frances');},),
            const SizedBox(height: 20),
            CardType(icon: Remix.money_rupee_circle_line,title: 'Sistema Aleman',onTap: (){context.push('/sistema-aleman');},),
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
      height: 480,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderHoverPainter(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Text('Es una forma de reconocer el costo de un activo a lo largo del tiempo, en lugar de hacerlo en un solo período.', style: textStyles.titleSmall?.copyWith(fontSize: 18, ),textAlign: TextAlign.justify,),
              const SizedBox(height: 15,),
              Text.rich(
                textAlign: TextAlign.justify,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Capitalización: ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "implica el crecimiento de una inversión o un activo através del tiempo debido a la acumulación de intereses o rendimientoscompuestos. ",
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
                      text: 'Capitalización Simple: ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "Calcula los intereses únicamente sobre el capital original, sin tener en cuenta los intereses acumulados en períodos anteriores.",
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
                      text: 'Capitalización Compuesta: ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "Calcula intereses sobre el capital inicial más los intereses acumulados.",
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