import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

import 'package:teslo_shop/features/shared/shared.dart';
import 'package:teslo_shop/features/shared/widgets/push_notificator.dart';


class TiempoCompuestoPage extends StatefulWidget {

  const TiempoCompuestoPage({super.key});

  @override
  State<TiempoCompuestoPage> createState() => _TiempoCompuestoPageState();
}

class _TiempoCompuestoPageState extends State<TiempoCompuestoPage> {


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

  TextEditingController interesController = TextEditingController();
  TextEditingController valorfinalController = TextEditingController();
  TextEditingController capitalController = TextEditingController();
  bool tasaInteresMensual = true;

  @override
  Widget build(BuildContext context) {


    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;


    return Scaffold(
      appBar: AppBar(
        title: Text('FinanceMaster', style: TextStyle(color: colors.primary)),

      ),
      body: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 50,
          ),
          Icon(
            Remix.time_fill,
            size: 150,
            color: colors.primary,
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  'Para hallar el Tiempo se utiliza la siguiente formula: Tiempo (N) = log(VF / C) / log(1 + i)\nDonde VF Valor futuro o Monto final, C es capital e i es tasa de interés',
                  style: textStyle.titleSmall?.copyWith(color: colors.secondary, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 50,),
                CustomTextFormField(
                  label: 'Interes',
                  // hint: 'Ingrese el capital',
                  keyboardType: TextInputType.number,
                  hintStyle: const TextStyle(fontSize: 18),
                  // backgroundColor: const Color(0xFFB0F2C2).withOpacity(0.5),
                  icon: Icon(Remix.coins_fill, color: colors.primary,size: 30, ),
                  controller: interesController,
                ),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tasa de Interés Mensual',
                          style: textStyle.titleSmall
                        ),
                        Radio(
                          value: true,
                          groupValue: tasaInteresMensual,
                          onChanged: (value) {
                            setState(() {
                              tasaInteresMensual = value as bool;
                            });
                          },
                        ),
                        
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tasa de Interés Anual',
                          style: textStyle.titleSmall
                        ),
                        Radio(
                          value: false,
                          groupValue: tasaInteresMensual,
                          onChanged: (value) {
                            setState(() {
                              tasaInteresMensual = value as bool;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20,),
                CustomTextFormField(
                  label: 'Capital',
                  // hint: 'Ingrese el capital',
                  keyboardType: TextInputType.number,
                  hintStyle: const TextStyle(fontSize: 18),
                  // backgroundColor: const Color(0xFFB0F2C2).withOpacity(0.5),
                  icon: Icon(Remix.time_fill, color: colors.primary,size: 30, ),
                  controller: capitalController,

                ),


                const SizedBox(height: 20,),

                CustomTextFormField(
                  label: 'Tasa de interes',
                  // hint: 'Ingrese el capital',
                  keyboardType: TextInputType.number,
                  hintStyle: const TextStyle(fontSize: 18),
                  // backgroundColor: const Color(0xFFB0F2C2).withOpacity(0.5),
                  icon: Icon(Remix.exchange_funds_line, color: colors.primary,size: 30, ), 
                  controller: valorfinalController,      
                ),



                const SizedBox(height: 40,),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: CustomFilledButton(
                    text: 'Calcular', 
                    onPressed: () {


                      if(interesController.text.isEmpty || valorfinalController.text.isEmpty || capitalController.text.isEmpty){
                        showSnackbar(context, Text('Por favor llene todos los campos', style: textStyle.titleSmall?.copyWith(color: Colors.white, fontSize: 16),));
                        return;
                      }

                      double interes = double.parse(interesController.text)/100;
                      double montofinal = double.parse(valorfinalController.text);
                      double capital = double.parse(capitalController.text);

                      double tiempo = MontoCalculator.calcularTimeCompuesto(interes, montofinal, capital);

                      showDialog(
                        context: context, 
                        //con el barrierDismissible: false, no se puede cerrar el dialogo dando click afuera
                        barrierDismissible: false,
                        builder: (context) {
                          return PushNotificator(data: tiempo, title: 'Resultado',content: 'Tiempo: ',simbolo: tasaInteresMensual ? ' meses' : ' años',);
                        },
                      );
                      


                      // ref.read(montoSimpleFormNotifierProvider.notifier).onFormSubmitted();
                      // if(montoForm.isValid) {

                      //   double tiempo = MontoCalculator.calcularTime(montoForm.capital.value, montoForm.interes.value, montoForm.tiempo.value, );


                      //   // showSnackbar(context, Text('El monto final es: $montoFinal', style: textStyle.titleSmall?.copyWith(color: Colors.white, fontSize: 16),));
                      // }else {
                      //   showSnackbar(context, Text('Formulario invalido', style: textStyle.titleSmall?.copyWith(color: Colors.white, fontSize: 16),));

                      // }
                    },
                    ),
                ),

              ],
            ),
            ),
        ],
      ),
    );
  }
}



