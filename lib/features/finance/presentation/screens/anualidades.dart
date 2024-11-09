import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:remixicon/remixicon.dart';
import 'package:teslo_shop/features/shared/shared.dart';
import 'package:teslo_shop/features/shared/widgets/push_notificator.dart';

class AnualidadesScreen extends StatefulWidget {
  const AnualidadesScreen({super.key});

  @override
  State<AnualidadesScreen> createState() => _AnualidadesScreenState();
}

class _AnualidadesScreenState extends State<AnualidadesScreen> {

  TextEditingController montoController = TextEditingController();
  TextEditingController tasaController = TextEditingController();
  TextEditingController periodosController = TextEditingController();
  TextEditingController rentaController = TextEditingController();

  double monto = 0;
  double tasa = 0;
  int periodos = 0;
  double renta = 0;

  String selectedOption = 'Valor Futuro';
  String formula = '';
  double resultado = 0;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB0F2C2),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 10, 115, 37)),
        centerTitle: true,
        title: Text('ANUALIDADES', style: textStyle.titleMedium?.copyWith(color: const Color.fromARGB(255, 10, 115, 37), fontSize: 25, ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _CustomPainterView(),
            const SizedBox(height: 5),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomFilledButton(
                  text: 'Valor Futuro',
                  onPressed: (){
                    setState(() {
                    selectedOption = 'Valor Futuro';
                    updateFormula();
                  });
                  },
                ),
                const SizedBox(width: 20),
                CustomFilledButton(
                  text: 'Valor Presente',
                  onPressed: (){
                    setState(() {
                    selectedOption = 'Valor Presente';
                    updateFormula();
                  });
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  if (selectedOption == 'Valor Futuro') ...[
                    CustomTextFormField(
                      label: 'Monto de la Anualidad',
                      keyboardType: TextInputType.number,
                      hintStyle: const TextStyle(fontSize: 18),
                      icon: Icon(Remix.money_dollar_circle_line, color: colors.primary,size: 30, ),
                      controller: montoController,
                    ),
                    const SizedBox(height: 15),
                  ],
                  CustomTextFormField(
                    label: 'Renta',
                    keyboardType: TextInputType.number,
                    hintStyle: const TextStyle(fontSize: 18),
                    icon: Icon(Remix.discount_percent_fill, color: colors.primary,size: 30, ),
                    controller: rentaController,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            CustomTextFormField(
                              label: 'Numero de Periodos',
                              keyboardType: TextInputType.number,
                              hintStyle: const TextStyle(fontSize: 18),
                              icon: Icon(Remix.calendar_line, color: colors.primary,size: 20, ),
                              controller: periodosController,
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: PopupMenuButton<String>(
                                icon: Icon(Remix.questionnaire_line, color: colors.primary,size: 25, ),
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'Mensual',
                                    child: Text('Mensual'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'Trimestral',
                                    child: Text('Trimestral'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'Semestral',
                                    child: Text('Semestral'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'Anual',
                                    child: Text('Anual'),
                                  ),
                                ]
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    label: 'Tasa de Interes',
                    keyboardType: TextInputType.number,
                    hintStyle: const TextStyle(fontSize: 18),
                    icon: Icon(Remix.percent_line, color: colors.primary,size: 20, ),
                    controller: tasaController,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomFilledButton(
                      text: 'Calcular Resultado',
                      onPressed: () {
                        setState(() {
                          try {
                            
                            tasa = double.parse(tasaController.text) / 100;
                    
                            periodos = int.parse(periodosController.text);
                    
                            renta = rentaController.text.isEmpty ? 0 : double.parse(rentaController.text);
                    
                            if (selectedOption == 'Valor Futuro') {
                              if (montoController.text.isEmpty) {
                                resultado = calcularRenta(0, tasa, periodos, renta);
                                formula = 'VF = R / (((pow(1 + i, n) - 1) / i))';
                              } else {
                                monto = double.parse(montoController.text);
                                resultado = calcularRenta(monto, tasa, periodos, renta);
                                formula = 'VF = R * (((pow(1 + i, n) - 1) / i))';
                              }
                            } else {
                              resultado = calcularValorPresente(renta, tasa, periodos);
                              formula = 'VA = R * ((1 - pow(1 + i, -n)) / i)';
                            }
                    
                            tasaController.clear();
                            periodosController.clear();
                            rentaController.clear();
                    
                            if (selectedOption == 'Valor Futuro') {
                              montoController.clear();
                            }
                    
                            showDialog(
                            context: context, 
                            //con el barrierDismissible: false, no se puede cerrar el dialogo dando click afuera
                            barrierDismissible: false,
                            builder: (context) {
                              return PushNotificator(
                                title: 'Resultado',
                                data: resultado,
                              );
                            },
                          );
                    
                    
                          } catch (e) {
                            showSnackbar(
                              context,
                              const Text('Error al calcular el resultado, por favor verifica los datos ingresados.'),
                            );
                          }
                        });
                      },
                    
                    ),
                  )
                ],
              ),
            ),
            

            const SizedBox(height: 70),
          ],
        )
      )
      
    );
  }

  void showSnackbar( BuildContext context, Text text ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: text,
        duration: const Duration(seconds: 2),
        // backgroundColor: Theme.of(context).colorScheme.primary,
      )
    );
  }

  void updateFormula() {
    setState(() {
      if (selectedOption == 'Valor Futuro') {
        formula = 'VF = R / (((pow(1 + i, n) - 1) / i))';
      } else {
        formula = 'VA = R * ((1 - pow(1 + i, -n)) / i)';
      }
    });
  }

  double calcularRenta(double monto, double i, int n, double renta) {
    if (monto == 0) {
      return renta * (((pow(1 + i, n) - 1) / i));
    } else {
      return monto / (((pow(1 + i, n) - 1) / i));
    }
  }

  double calcularValorFuturo(double A, double i, int n) {
    if (A == 0) {
      return A / (((pow(1 + i, n) - 1) / i));
    } else {
      return monto * (((pow(1 + i, n) - 1) / i));
    }
  }

  double calcularValorPresente(double R, double i, int n) {
    return R * ((1 - pow(1 + i, -n)) / i);
  }
}


class _CustomPainterView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      // color: const Color(0xFFB0F2C2).withOpacity(0.5),
      height: 870,
      width: double.infinity,
      child: CustomPaint(
        painter: _HeaderHoverPainter(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Text.rich(
                textAlign: TextAlign.justify,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Las anualidades ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),                    
                    TextSpan(
                      text: "son serie de pagos o depósitos iguales que se realizan o reciben a intervalos regulares durante un período específico de tiempo.",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18, )
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
                      text: 'La Tasa de Interés (i) ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "Representa la tasa de interés aplicada a la anualidad, expresada como un porcentaje.",
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
                      text: 'El Número de Períodos (n) ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "Indica la cantidad de períodos en los que se realizarán los pagos o depósitos.",
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
                      text: 'la Renta ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "Corresponde al pago o depósito que se realiza de manera regular en la anualidad.",
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
                      text: 'Monto de la Anualidad ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "Es el valor inicial de la anualidad, en caso de haberlo.",
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
                      text: 'Fórmulas: ',
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
                    ),
                    TextSpan(
                      text: "Valor Futuro (VF): Representa el valor acumulado de una anualidad en un momento futuro.",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),

                  ]
                )
              ),
              const SizedBox(height: 15,),
              Text('Fórmula (Renta) y Formula (Monto):', style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),),
              const SizedBox(height: 15,),
              Math.tex(
                r'VF=\frac{M}{\left[\frac{\left(1+i\right)^n-1}{i}\right]}',
                textStyle: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 16)
              ),
              const SizedBox(height: 15,),
              Math.tex(
                r'VF=R\left[\frac{\left(1+i\right)^n-1}{i}\right]',
                textStyle: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 16)
              ),
              const SizedBox(height: 15,),
              Text.rich(
                textAlign: TextAlign.justify,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Valor Presente (VP): Indica el valor actual de una anualidad, es decir, su valor en el presente.",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18)
                    ),
                  ]
                )
              ),
              Math.tex(
                r'VP=R\left[\frac{1-\left(1+i\right)^{-n}}{i}\right]',
                textStyle: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 16)
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