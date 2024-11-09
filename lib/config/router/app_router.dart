import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/finance/presentation/pages/amortizacion/capitalizacion_compuesta.dart';
import 'package:teslo_shop/features/finance/presentation/pages/amortizacion/capitalizacion_simple.dart';
import 'package:teslo_shop/features/finance/presentation/pages/amortizacion/sistema_aleman.dart';
import 'package:teslo_shop/features/finance/presentation/pages/amortizacion/sistema_americano.dart';
import 'package:teslo_shop/features/finance/presentation/pages/amortizacion/sistema_frances.dart';
import 'package:teslo_shop/features/finance/presentation/pages/gradientes/aritmetico.dart';
import 'package:teslo_shop/features/finance/presentation/pages/gradientes/escalonado.dart';
import 'package:teslo_shop/features/finance/presentation/pages/gradientes/geometrico.dart';
import 'package:teslo_shop/features/finance/presentation/pages/pages.dart';
import 'package:teslo_shop/features/finance/presentation/screens/amortizacion.dart';
import 'package:teslo_shop/features/finance/presentation/screens/gradientes.dart';
import 'package:teslo_shop/features/finance/presentation/screens/tir.dart';
import 'package:teslo_shop/features/finance/products.dart';

import 'app_router_notifier.dart';

final goRouterProvider = Provider((ref) {

  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      ///* Primera pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Finance Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const FinanceScreen(),
      ),
      
      //!interes simple
      GoRoute(
        path: '/interes-simple',
        builder: (context, state) => const InteresSimpleScreen(),
      ),
      GoRoute(
        path: '/monto-simple',
        builder: (context, state) => const MontoSimplePage(),
      ),
      GoRoute(
        path: '/interes-simple-page',
        builder: (context, state) => const InteresSimplePage(),
      ),
      GoRoute(
        path: '/capital-simple',
        builder: (context, state) => const CapitalSimplePage(),
      ),
      GoRoute(
        path: '/tasa-interes-simple',
        builder: (context, state) => const TasaInteresSimplePage(),
      ),
      GoRoute(
        path: '/tiempo-simple',
        builder: (context, state) => const TiempoSimplePage(),
      ),

      //!interes compuesto
      GoRoute(
        path: '/interes-compuesto',
        builder: (context, state) => const InteresCompuestoScreen(),
      ),
      GoRoute(
        path: '/monto-compuesto',
        builder: (context, state) => const MontoCompuestoPage(),
      ),
      GoRoute(
        path: '/monto-periodo',
        builder: (context, state) => const MontoPeridoPage(),
      ),
      GoRoute(
        path: '/capital-compuesto',
        builder: (context, state) => const CapitalCompuestoPage(),
      ),
      GoRoute(
        path: '/tasa-compuesto',
        builder: (context, state) => const TasaInteresCompuestaPage(),
      ),
      GoRoute(
        path: '/tiempo-compuesto',
        builder: (context, state) => const TiempoCompuestoPage(),
      ),

      //!anualidades
      GoRoute(
        path: '/anualidades',
        builder: (context, state) => const AnualidadesScreen(),
      ),

      //!gradientes
      GoRoute(
        path: '/gradientes',
        builder: (context, state) => const GradientesScreen(),
      ),
      GoRoute(
        path: '/aritmetico',
        builder: (context, state) => const AritmeticoPage(),
      ),
      GoRoute(
        path: '/geometrico',
        builder: (context, state) => const GeometricoPage(),
      ),
      GoRoute(
        path: '/escalonado',
        builder: (context, state) => const EscalonadoPage(),
      ),

      //!amortizacion
      GoRoute(
        path: '/amortizacion',
        builder: (context, state) => const AmortizacionScreen(),
      ),
      GoRoute(
        path: '/capitalizacion-simple',
        builder: (context, state) => const CapitalizacionSimplePage(),
      ),
      GoRoute(
        path: '/capitalizacion-compuesta',
        builder: (context, state) => const CapitalizacionCompuestaPage(),
      ),
      GoRoute(
        path: '/sistema-americano',
        builder: (context, state) => const SistemaAmericanoPage(),
      ),
      GoRoute(
        path: '/sistema-frances',
        builder: (context, state) => const SistemaFrancesPage(),
      ),
      GoRoute(
        path: '/sistema-aleman',
        builder: (context, state) => const SistemaAlemanPage(),
      ),

      //!tir
      GoRoute(
        path: '/tir',
        builder: (context, state) => const TirPage(),
      ),

    ],

    redirect: (context, state) {
      
      final isGoingTo = state.subloc;
      final authStatus = goRouterNotifier.authStatus;

      if ( isGoingTo == '/splash' && authStatus == AuthStatus.checking ) return null;

      if ( authStatus == AuthStatus.notAuthenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' ) return null;

        return '/login';
      }

      if ( authStatus == AuthStatus.authenticated ) {
        if ( isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash' ){
           return '/';
        }
      }


      return null;
    },
  );
});
