import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';
import 'package:teslo_shop/features/shared/shared.dart';

class EscalonadoCalculator {
  static Map<String, double> calcularValorPresente(double seriePagos, double tasaInteres, int nPeriodos, double tasaEfectiva, double tasaIncremento, int plazoObligacion) {
    double parte1 = (pow((1 + tasaInteres), nPeriodos) - 1) / tasaInteres;
    double parte2 = ((pow((1 + tasaEfectiva), plazoObligacion) - (1 + tasaIncremento)) / ((pow((1 + tasaEfectiva), plazoObligacion)) * (tasaEfectiva - tasaInteres)));
    double valorPresente = seriePagos * parte1 * parte2;
    return {'valorPresente': valorPresente};
  }
}

class EscalonadoPage extends StatefulWidget {
  const EscalonadoPage({super.key});

  @override
  State<EscalonadoPage> createState() => _EscalonadoPageState();
}

class _EscalonadoPageState extends State<EscalonadoPage> {

  TextEditingController seriePagosController = TextEditingController();
  TextEditingController tasaInteresController = TextEditingController();
  TextEditingController tasaEfectivaController = TextEditingController();
  TextEditingController nPeriodosController = TextEditingController();
  TextEditingController plazoObligacionController = TextEditingController();
  TextEditingController tasaIncrementoController = TextEditingController();
  String? tipoGradiente; // Creciente, decreciente
  double? valorPresente;

  void calcularResultado() {
    double seriePagos = double.tryParse(seriePagosController.text) ?? 0;
    double tasaInteres = double.tryParse(tasaInteresController.text) ?? 0;
    double tasaEfectiva = double.tryParse(tasaEfectivaController.text) ?? 0;
    int nPeriodos = int.tryParse(nPeriodosController.text) ?? 0;
    int plazoObligacion = int.tryParse(plazoObligacionController.text) ?? 0;
    double tasaIncremento = double.tryParse(tasaIncrementoController.text) ?? 0;

    // Calcular el valor presente
    Map<String, double> resultado = EscalonadoCalculator.calcularValorPresente(seriePagos, tasaInteres/100, nPeriodos, tasaEfectiva/100, tasaIncremento/100, plazoObligacion);

    setState(() {
      valorPresente = resultado['valorPresente'];
    });

    // Mostrar el resultado en un diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Resultado',
            style: GoogleFonts.saira(
              color: const Color(0xFF29E9FF),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Valor Presente (VP): \$${valorPresente?.toStringAsFixed(2)}',
                style: GoogleFonts.saira(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: GoogleFonts.saira(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF29E9FF),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ESCALONADO",
          style: TextStyle(color: colors.primary),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Escalonado", style: textStyle.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18,),
                        ),
                        TextSpan(
                          text: " es un tipo de gradiente el cual sus valores son constantes durante los periodos de un año," 
                                " pero que puede aumentar o disminuir en una cantidad fija de dinero o en una tasa constante.", style: textStyle.titleSmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: " Donde P ó VP es valor inicial de la obligación", 
                          style: textStyle.titleSmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Math.tex(
                    r'P=A_1\left[\frac{\left(1+i\right)^n-1}{i}\right]\left[\frac{\left(1+TEA\right)^E-\left(1+J\right)}{\left(1+TEA\right)^E\left(1-J\right)}\right]',
                    textStyle: textStyle.titleSmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomTextFormField(
                    label: "Valor cuota (A)", 
                    icon:Icon( Remix.coins_fill, color: colors.primary,size: 25,),
                    hintStyle: const TextStyle(fontSize: 18), 
                    controller: seriePagosController,
                  ),
                  const SizedBox(height: 20,),
                  CustomTextFormField(
                    label: "Tasa de Interés por periodo (i)", 
                    icon:Icon( Remix.discount_percent_fill, color: colors.primary,size: 25,),
                    hintStyle: const TextStyle(fontSize: 18), 
                    controller: tasaInteresController,
                  ),
                  const SizedBox(height: 20,),
                  CustomTextFormField(
                    label: "Número periodos (n)", 
                    icon:Icon( Remix.numbers_line, color: colors.primary,size: 25,),
                    hintStyle: const TextStyle(fontSize: 18), 
                    controller: nPeriodosController,
                  ),
                  const SizedBox(height: 20,),
                  CustomTextFormField(
                    label: "Tasa efectiva anual (TEA)", 
                    icon:Icon( Remix.percent_line, color: colors.primary,size: 25,),
                    hintStyle: const TextStyle(fontSize: 18), 
                    controller: tasaEfectivaController,
                  ),
                  const SizedBox(height: 20,),
                  CustomTextFormField(
                    label: "Tasa incremento (J)", 
                    icon:Icon( Remix.swap_line, color: colors.primary,size: 25,),
                    hintStyle: const TextStyle(fontSize: 18), 
                    controller: tasaIncrementoController,
                  ),
                  const SizedBox(height: 20,),
                  CustomTextFormField(
                    label: "Plazo obligación (E)", 
                    icon:Icon( Remix.calendar_todo_line, color: colors.primary,size: 25,),
                    hintStyle: const TextStyle(fontSize: 18), 
                    controller: plazoObligacionController,
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: CustomFilledButton(
                      text: 'Calcular',
                      onPressed: calcularResultado,
                    ),
                    // child: TextButton(
                    //   style: TextButton.styleFrom(
                    //     foregroundColor: const Color(0xFF29E9FF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    //     backgroundColor: const Color(0xFF171731),
                    //   ),
                    //   onPressed: calcularResultado,
                    //   child: Text(
                    //     'Calcular Resultado',
                    //     style: GoogleFonts.saira(
                    //       fontSize: 17,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white
                    //     ),
                    //   ),
                    // ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
