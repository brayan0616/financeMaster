import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';
import 'package:teslo_shop/features/shared/shared.dart';
import 'package:teslo_shop/features/shared/widgets/botton_gordo.dart';


class ItemBoton {

  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final Function()? onPress;

  ItemBoton(
    this.icon, 
    this.texto, 
    this.color1, 
    this.color2,
    this.onPress,
    );
}


class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    final items = <ItemBoton>[
      ItemBoton( Remix.funds_fill, 'Interes simple', const Color(0xFF89CFF0), const Color(0xFF98FF98),(){context.push('/interes-simple');} ),
      ItemBoton( Remix.exchange_funds_line, 'Interes Compuesto', const Color(0xFFFFA07A), const Color(0xFFFFE135),(){context.push('/interes-compuesto');} ),
      ItemBoton( Remix.calendar_todo_fill, 'Anualidades', const Color(0xFFB39DDB), const Color(0xFFFFC1CC),(){context.push('/anualidades');} ),
      ItemBoton( Remix.line_chart_line, 'Gradientes', const Color(0xFF1E90FF), const Color(0xFF006400),(){context.push('/gradientes');} ),
      ItemBoton( Remix.hand_coin_line, 'Amortizacion', const Color(0xFFFF69B4), const Color(0xFFFFFF99),(){context.push('/amortizacion');} ),
      ItemBoton( Remix.line_chart_line, 'TIR', const Color(0xFF40E0D0), const Color(0xFFADFF2F),(){context.push('/tir');} ),
      
    ];


    List<Widget> itemMap = items.map((item) => FadeIn(
      delay: const Duration( milliseconds: 250 ),
      child: BotonGordo(
        icon: item.icon,
        texto: item.texto,
        onPress: item.onPress,
        color1: item.color1,
        color2: item.color2,
      ),
    )).toList();
    // final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // drawer: SideMenu( scaffoldKey: scaffoldKey ),
      // appBar: AppBar(
      //   title: const Text('FinanceMaster'),
      //   actions: [
      //     IconButton(
      //       onPressed: (){}, 
      //       icon: const Icon( Icons.light_mode_outlined)
      //     )
      //   ],
      // ),
      backgroundColor: colors.background,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 200),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox( height: 70 ),
                ...itemMap
              ],
            ),
          ),

          const IconHeader(
            icon: FontAwesomeIcons.wallet,
            title: 'FinanceMaster',
            subtitle: 'tu aliado financiero',
          ),

        ],

      )
      // floatingActionButton: FloatingActionButton.extended(
      //   label: Text('Nuevo producto'),
      //   icon: Icon( Icons.add ),
      //   onPressed: () {},
      // ),
    );
  }
}

class BotonGordoTemp extends StatelessWidget {
  const BotonGordoTemp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BotonGordo(
      icon: Remix.funds_fill,
      texto: 'Interes Simple',
      onPress: (){},
    );
  }
}

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const IconHeader(
      icon: FontAwesomeIcons.wallet,
      title: 'FinanceMaster',
      subtitle: 'tu aliado financiero',
    );
  }
}

