import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teslo_shop/features/shared/shared.dart';
import 'package:teslo_shop/features/shared/widgets/push_notificator.dart';

class TirPage extends StatefulWidget {
  const TirPage({Key? key}) : super(key: key);

  @override
  _TirPageState createState() => _TirPageState();
}

class _TirPageState extends State<TirPage> {

  TextEditingController controllerInversion = TextEditingController();
  TextEditingController controllerTasaDescuento = TextEditingController();
  List<TextEditingController> controllersFlujosDeCaja = [TextEditingController()];

  double tir = 0.0;
  double van = 0.0;
  String mensajeError = '';

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB0F2C2),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 10, 115, 37)),
        centerTitle: true,
        title: Text('TIR', style: textStyles.titleMedium?.copyWith(color: const Color.fromARGB(255, 10, 115, 37), fontSize: 25, ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: <TextSpan>[

                    TextSpan(
                      text: "Su fórmula es:",
                     style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Math.tex(
                r'\sum \left(\frac{FCi}{\left(1+TD\right)^i}\right)',
                textStyle: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              const SizedBox(height: 10,),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Inversión: ",
                     style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextSpan(
                      text: "Es el monto de dinero que se coloca en un proyecto o negocio al comienzo del mismo.\n\n",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    TextSpan(
                      text: "Tasa de Descuento (TD):",
                     style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextSpan(
                      text: "Porcentaje que representa el costo de financiar una inversión o proyecto\n\n",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    TextSpan(
                      text: "Flujo de caja: ",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextSpan(
                      text: "Son los movimientos de dinero que ingresan o salen durante un tiempo específico.",
                      style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: controllerInversion,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Inversión',
                  labelStyle: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.monetization_on, color: colors.primary),
                ),
                style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un valor';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: controllerTasaDescuento,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Tasa de Descuento (opcional para calcular el VAN)',
                  labelStyle: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.trending_down, color: colors.primary),
                ),
                style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 20.0),
              Text(
                'Flujos de Caja',
                style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10.0),
              Column(
                children: _crearCamposFlujosDeCaja(colors,textStyles),
              ),
              const SizedBox(height: 20.0),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomFilledButton(
                  text: 'Calcular Resultados',
                  onPressed: () {
                    if (_validarEntradas()) {
                    if (controllerTasaDescuento.text.isNotEmpty) {
                      calcularVAN();
                    } else {
                      calcularTIR();
                    }
                  } else {
                    setState(() {
                      mensajeError = 'Se ingresaron valores incorrectos';
                      tir = 0.0;
                      van = 0.0;
                    });
                    showSnackbar(context, Text(mensajeError));
                  }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _crearCamposFlujosDeCaja(ColorScheme colors, TextTheme textStyles) {
    List<Widget> campos = [];
    for (int i = 0; i < controllersFlujosDeCaja.length; i++) {
      campos.add(
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controllersFlujosDeCaja[i],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Flujo ${i + 1}',
                      labelStyle: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.monetization_on,color: colors.primary, ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.delete, color: colors.primary,),
                        onPressed: () {
                          setState(() {
                            controllersFlujosDeCaja.removeAt(i);
                          });
                        },
                      ),
                    ),
                    style: textStyles.titleSmall?.copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa un valor';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor ingresa un número válido';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      );
    }
    campos.add(
      Column(
        children: [
          IconButton(
            icon: Icon(Icons.add, color: colors.primary,),
            onPressed: () {
              setState(() {
                controllersFlujosDeCaja.add(TextEditingController());
              });
            },
          ),
        ],
      ),
    );
    return campos;
  }

  bool _validarEntradas() {
    if (controllerInversion.text.isEmpty ||
        controllersFlujosDeCaja.any((controller) => controller.text.isEmpty || double.tryParse(controller.text) == null)) {
      return false;
    }
    return true;
  }

  void calcularTIR() {
    double inversion = double.parse(controllerInversion.text);
    List<double> flujosDeCaja = controllersFlujosDeCaja.map((controller) => double.parse(controller.text)).toList();
    flujosDeCaja.insert(0, -inversion);
    tir = tasaInternaDeRetorno(flujosDeCaja);
    setState(() {
      mensajeError = '';
    });
    mostrarAlertaResultado();
  }

  double tasaInternaDeRetorno(List<double> flujosDeCaja) {
    double tasaMin = -1.0;
    double tasaMax = 1.0;
    double tasaAprox = (tasaMin + tasaMax) / 2.0;
    double vpn;

    while (tasaMax - tasaMin > 0.0001) {
      vpn = 0.0;
      for (int i = 0; i < flujosDeCaja.length; i++) {
        vpn += flujosDeCaja[i] / pow(1 + tasaAprox, i);
      }

      if (vpn > 0) {
        tasaMin = tasaAprox;
      } else {
        tasaMax = tasaAprox;
      }
      tasaAprox = (tasaMin + tasaMax) / 2.0;
    }

    return tasaAprox * 100.0;
  }

  void calcularVAN() {
    double inversion = double.parse(controllerInversion.text);
    List<double> flujosDeCaja = controllersFlujosDeCaja.map((controller) => double.parse(controller.text)).toList();
    flujosDeCaja.insert(0, -inversion);
    double tasaDescuento = double.parse(controllerTasaDescuento.text) / 100.0;
    van = valorActualNeto(flujosDeCaja, tasaDescuento);
    setState(() {
      mensajeError = '';
    });
    mostrarAlertaVAN();
  }

  double valorActualNeto(List<double> flujosDeCaja, double tasaDescuento) {
    double van = 0.0;
    for (int i = 0; i < flujosDeCaja.length; i++) {
      van += flujosDeCaja[i] / pow(1 + tasaDescuento, i);
    }
    return van;
  }

  void mostrarAlertaResultado() {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return PushNotificator(
          title: 'Resultado TIR',
          data: tir,
        );

        // return AlertDialog(
        //   title: Text(
        //     'Resultado TIR',
        //     style: GoogleFonts.saira(
        //       color: const Color(0xFF29E9FF),
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   content: Text(
        //     '${tir.toStringAsFixed(2)}%',
        //     style: GoogleFonts.saira(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 16,
        //     ),
        //   ),
        //   actions: [
        //     TextButton(
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //         limpiarCampos();
        //       },
        //       child: Text(
        //         'OK',
        //         style: GoogleFonts.saira(
        //           fontSize: 16,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //   ],
        // );
      },
    );
  }

  void mostrarAlertaVAN() {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return PushNotificator(
          title: 'Resultado VAN',
          data: van,
        );

        // return AlertDialog(
        //   title: Text(
        //     'Resultado VAN',
        //     style: GoogleFonts.saira(
        //       color: const Color(0xFF29E9FF),
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        //   content: Text(
        //     '\$${van.toStringAsFixed(2)}',
        //     style: GoogleFonts.saira(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 16,
        //     ),
        //   ),
        //   actions: [
        //     TextButton(
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //         limpiarCampos();
        //       },
        //       child: Text(
        //         'OK',
        //         style: GoogleFonts.saira(
        //           fontSize: 16,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //   ],
        // );
      },
    );
  }

  void mostrarAlertaError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Error',
            style: GoogleFonts.saira(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            mensajeError,
            style: GoogleFonts.saira(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
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
                ),
              ),
            ),
          ],
        );
      },
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

  void limpiarCampos() {
    setState(() {
      controllerInversion.clear();
      controllerTasaDescuento.clear();
      controllersFlujosDeCaja.clear();
      controllersFlujosDeCaja.add(TextEditingController());
    });
  }
}
