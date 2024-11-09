import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';

import 'package:teslo_shop/features/shared/shared.dart';



class AritmeticoPage extends StatefulWidget {

  const AritmeticoPage({super.key});

  @override
  State<AritmeticoPage> createState() => _TiempoCompuestoPageState();
}

enum TipoGradiente { creciente, decreciente, anticipado, vencido }

class _TiempoCompuestoPageState extends State<AritmeticoPage> {


  void showSnackbar( BuildContext context, Text text ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: text,
        duration: const Duration(seconds: 1),
        // backgroundColor: Theme.of(context).colorScheme.primary,
      )
    );
  }
  final GlobalKey<ExpansionTileCardState> cardKey = GlobalKey();
  TextEditingController seriePagosController = TextEditingController();
  TextEditingController tasaInteresController = TextEditingController();
  TextEditingController variacionController = TextEditingController();
  TextEditingController nPeriodosController = TextEditingController();
  TipoGradiente tipoGradiente = TipoGradiente.creciente; // Creciente, decreciente, anticipado, vencido
  double? valorPresente;
  double? valorFuturo;

  // void initState() {
  //   super.initState();
  //   tipoGradiente = 'Creciente';
  // }

  String obtenerFormulaValorPresente() {
    return AritmeticoCalculator.obtenerFormulaValorPresente(tipoGradiente.name);
  }

  String obtenerFormulaValorFuturo() {
    return AritmeticoCalculator.obtenerFormulaValorFuturo(tipoGradiente.name);
  }

  void calcularResultado() {
    double seriePagos = double.tryParse(seriePagosController.text) ?? 0;
    double tasaInteres = double.tryParse(tasaInteresController.text) ?? 0;
    double variacion = double.tryParse(variacionController.text) ?? 0;
    int nPeriodos = int.tryParse(nPeriodosController.text) ?? 0;

    // if (tipoGradiente == null) {
    //   // Mostrar mensaje de error si no se ha seleccionado un tipo de gradiente
    //   showSnackbar(
    //     context,
    //     const Text('Por favor seleccione un tipo de gradiente.'),
    //   );
    //   return;
    // }

    // Calcular el valor presente y el valor futuro según el tipo de gradiente seleccionado
    switch (tipoGradiente.name) {
      case 'creciente':
        final resultCreciente = AritmeticoCalculator.calcularCreciente(seriePagos, tasaInteres/100, variacion, nPeriodos);
        valorPresente = resultCreciente['valorPresente'];
        valorFuturo = resultCreciente['valorFuturo'];
        break;
      case 'decreciente':
        final resultDecreciente = AritmeticoCalculator.calcularDecreciente(seriePagos, tasaInteres/100, variacion, nPeriodos);
        valorPresente = resultDecreciente['valorPresente'];
        valorFuturo = resultDecreciente['valorFuturo'];
        break;
      case 'anticipado':
        final resultAnticipado = AritmeticoCalculator.calcularAnticipado(seriePagos, tasaInteres/100, variacion, nPeriodos);
        valorPresente = resultAnticipado['valorPresente'];
        valorFuturo = resultAnticipado['valorFuturo'];
        break;
      case 'vencido':
        final resultVencido = AritmeticoCalculator.calcularVencido(seriePagos, tasaInteres/100, variacion, nPeriodos);
        valorPresente = resultVencido['valorPresente'];
        valorFuturo = resultVencido['valorFuturo'];
        break;
      default:
        // Esto no debería ocurrir, pero por si acaso
        valorPresente = 0;
        valorFuturo = 0;
        break;
    }

    // Mostrar el resultado en un diálogo
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Resultado',
            style: GoogleFonts.montserratAlternates(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Valor Presente (VP): \$${valorPresente?.toStringAsFixed(2)}',
                style: GoogleFonts.montserratAlternates(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Valor Futuro (VF): \$${valorFuturo?.toStringAsFixed(2)}',
                style: GoogleFonts.montserratAlternates(
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
                style: GoogleFonts.montserratAlternates(
                  fontSize: 16,

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
        title: Text('ARITMETICO', style: TextStyle(color: colors.primary)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [                 
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Aritmético o Lineal", style: textStyle.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        TextSpan(
                          text: " es un tipo de gradiente el cual cada pago es igual al del periodo anterior," 
                                " aumentando o dosminuyendo en una cantidad de dinero constante.", style: textStyle.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        TextSpan(
                          text: " Donde VP ó P es valor presente y VF ó F es valor futuro", 
                          style: textStyle.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ]
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        Math.tex(
                          obtenerFormulaValorPresente(),
                          textStyle: textStyle.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 13)
                        ),
                        const SizedBox(height: 20,),
                        Math.tex(
                          obtenerFormulaValorFuturo(),
                          textStyle: textStyle.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20,),

                  ExpansionTileCard(
                    key: cardKey,
                    title: Text(tipoGradiente.name, style: textStyle.titleSmall,),
                    children: [
                      RadioListTile(
                        title: Text('Creciente', style: textStyle.titleSmall?.copyWith(fontSize: 16),),
                        value: TipoGradiente.creciente, 
                        groupValue: tipoGradiente, 
                        onChanged: (value) {
                          setState(() {
                            tipoGradiente = TipoGradiente.creciente;
                            cardKey.currentState?.collapse();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Decreciente', style: textStyle.titleSmall?.copyWith(fontSize: 16),),
                        value: TipoGradiente.decreciente, 
                        groupValue: tipoGradiente, 
                        onChanged: (value) {
                          setState(() {
                            tipoGradiente = TipoGradiente.decreciente;
                            cardKey.currentState?.collapse();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Anticipado', style: textStyle.titleSmall?.copyWith(fontSize: 16),),
                        value: TipoGradiente.anticipado, 
                        groupValue: tipoGradiente, 
                        onChanged: (value) {
                          setState(() {
                            tipoGradiente = TipoGradiente.anticipado;
                            cardKey.currentState?.collapse();
                          });
                        },
                      ),
                      RadioListTile(
                        title: Text('Vencido', style: textStyle.titleSmall?.copyWith(fontSize: 16),),
                        value: TipoGradiente.vencido, 
                        groupValue: tipoGradiente, 
                        onChanged: (value) {
                          setState(() {
                            tipoGradiente = TipoGradiente.vencido;
                            cardKey.currentState?.collapse();
                          });
                        },
                      ),
                    ],
                  ),

                const SizedBox(height: 20,),
        
                  CustomTextFormField(
                    label: 'Valor cuota (A)',
                    // hint: 'Ingrese el capital',
                    keyboardType: TextInputType.number,
                    hintStyle: const TextStyle(fontSize: 18),
                    // backgroundColor: const Color(0xFFB0F2C2).withOpacity(0.5),
                    icon: Icon(Remix.coins_fill, color: colors.primary,size: 30, ),
                    controller: seriePagosController,
                  ),
        
                  const SizedBox(height: 20,),
                  CustomTextFormField(
                    label: 'Tasa de Interés (i)',
                    // hint: 'Ingrese el capital',
                    keyboardType: TextInputType.number,
                    hintStyle: const TextStyle(fontSize: 18),
                    // backgroundColor: const Color(0xFFB0F2C2).withOpacity(0.5),
                    icon: Icon(Remix.discount_percent_fill, color: colors.primary,size: 30, ),
                    controller: tasaInteresController,
        
                  ),
        
        
                  const SizedBox(height: 20,),
        
                  CustomTextFormField(
                    label: 'Variación (G)',
                    // hint: 'Ingrese el capital',
                    keyboardType: TextInputType.number,
                    hintStyle: const TextStyle(fontSize: 18),
                    // backgroundColor: const Color(0xFFB0F2C2).withOpacity(0.5),
                    icon: Icon(Remix.line_chart_fill, color: colors.primary,size: 30, ), 
                    controller: variacionController,      
                  ),
        
                  const SizedBox(height: 20,),
        
                  CustomTextFormField(
                    label: 'Número periodos (n)',
                    // hint: 'Ingrese el capital',
                    keyboardType: TextInputType.number,
                    hintStyle: const TextStyle(fontSize: 18),
                    // backgroundColor: const Color(0xFFB0F2C2).withOpacity(0.5),
                    icon: Icon(Remix.numbers_line, color: colors.primary,size: 30, ), 
                    controller: nPeriodosController,      
                  ),
        
        
        
                  const SizedBox(height: 40,),
                  SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: CustomFilledButton(
                      text: 'Calcular', 
                      onPressed: calcularResultado
                      ),
                  ),

                  const SizedBox(height: 20,),
        
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}