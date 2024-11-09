import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remixicon/remixicon.dart';
import 'package:teslo_shop/features/finance/presentation/providers/interes_simple/monto_simple_provider.dart';
import 'package:teslo_shop/features/shared/shared.dart';
import 'package:teslo_shop/features/shared/widgets/push_notificator.dart';


class TiempoSimplePage extends ConsumerWidget {

  const TiempoSimplePage({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final montoForm = ref.watch(montoSimpleFormNotifierProvider);

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
                  'Para hallar el Tiempo se utiliza la siguiente formula:',
                  style: textStyle.titleSmall?.copyWith(color: colors.secondary, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10,),
                Math.tex(
                  r't\:=\:\frac{I}{Ci}',
                  textStyle: textStyle.titleSmall?.copyWith(color: colors.secondary),
                ),
                
                Text(
                  'Donde t es tiempo, I es intereses, C es capital e i es tasa de interés',
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
                  onChanged:(value) => ref.read(montoSimpleFormNotifierProvider.notifier).onCapitalChange(int.parse(value)),
                ),

                const SizedBox(height: 20,),
                CustomTextFormField(
                  label: 'Capital',
                  // hint: 'Ingrese el capital',
                  keyboardType: TextInputType.number,
                  hintStyle: const TextStyle(fontSize: 18),
                  // backgroundColor: const Color(0xFFB0F2C2).withOpacity(0.5),
                  icon: Icon(Remix.time_fill, color: colors.primary,size: 30, ),
                  onChanged: (value) => ref.read(montoSimpleFormNotifierProvider.notifier).onTiempoChange(int.parse(value)),
                ),


                const SizedBox(height: 20,),

                CustomTextFormField(
                  label: 'Tasa de interes',
                  // hint: 'Ingrese el capital',
                  keyboardType: TextInputType.number,
                  hintStyle: const TextStyle(fontSize: 18),
                  // backgroundColor: const Color(0xFFB0F2C2).withOpacity(0.5),
                  icon: Icon(Remix.exchange_funds_line, color: colors.primary,size: 30, ),
                  onChanged:(value) => ref.read(montoSimpleFormNotifierProvider.notifier).onInteresChange(double.parse(value)),         
                ),



                const SizedBox(height: 40,),
                SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: CustomFilledButton(
                    text: 'Calcular', 
                    onPressed: () {
                      ref.read(montoSimpleFormNotifierProvider.notifier).onFormSubmitted();
                      if(montoForm.isValid) {

                        double tiempo = MontoCalculator.calcularTime(montoForm.capital.value, montoForm.interes.value, montoForm.tiempo.value, );

                        showDialog(
                          context: context, 
                          //con el barrierDismissible: false, no se puede cerrar el dialogo dando click afuera
                          barrierDismissible: false,
                          builder: (context) {
                            return PushNotificator(data: tiempo, title: 'Resultado',content: 'Tiempo',simbolo: ' años',);
                          },
                        );

                        // showSnackbar(context, Text('El monto final es: $montoFinal', style: textStyle.titleSmall?.copyWith(color: Colors.white, fontSize: 16),));
                      }else {
                        showSnackbar(context, Text('Formulario invalido', style: textStyle.titleSmall?.copyWith(color: Colors.white, fontSize: 16),));

                      }
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



class _ButtonSheetCustom extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25)
        )
      ),
      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: 120,
              height: 4,
              decoration: BoxDecoration(
                color: colors.primary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'Seleccione el periodo de tiempo',
              style: textStyle.titleSmall?.copyWith(color: colors.primary, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: _ListCircular())

        ] 
      )
    );
  }
}

class _ListCircular extends ConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final tiempoCurrent = ref.watch(tiempoFilterProvider);

    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return ListWheelScrollView(
      physics: const BouncingScrollPhysics(),
      itemExtent: 45,
      diameterRatio: 1.5,
      children: TiempoType.values.map((e) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {
              ref.read(tiempoFilterProvider.notifier).changeCurrentFilter(e);
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: tiempoCurrent == e ? colors.primary.withOpacity(0.5) : colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Center(
                child: Text(
                  e.name,
                  style: textStyle.titleSmall?.copyWith(color: colors.primary, fontSize: 16),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}