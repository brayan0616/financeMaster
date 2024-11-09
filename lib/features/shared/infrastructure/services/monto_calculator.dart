import 'dart:math';

class MontoCalculator {
  static double calcularTiempo(int valor, String unidadTiempo) {
    switch (unidadTiempo.toLowerCase()) {
      
      case 'dia':
        return valor / 365;
      case 'semana':
        return valor / 52.1775; // Asumiendo 52.1775 semanas en un año
      case 'mes':
        return valor / 12.0;
      case 'bimestral':
        return valor / 6.0;
      case 'trimestral':
        return valor / 4.0;
      case 'semestral':
        return valor / 2.0;
      case 'anual':
        return valor/1;
      case 'compuesto':
        return valor/1;
      case 'dos fechas':
        return valor/365;
      default:
        return 0.0;
    }
  }

  static double calcularTiempoFrances(double valor, String unidadTiempo) {
    switch (unidadTiempo.toLowerCase()) {
      case 'anual':
        return valor *12;
      case 'mes':
        return valor ; // Convertir meses a años
      case 'dia':
        return valor / 365;
      case 'semana':
        return valor / 52.1775; // Asumiendo 52.1775 semanas en un año
      case 'compuesto':
        return valor;
      case 'bimestral':
        return valor / 6.0;
      case 'trimestral':
        return valor / 4.0;
      case 'semestral':
        return valor / 2.0;
      default:
        return 0.0;
    }
  }

  static double calcularMontoFinal(int principal, double tasaInteres, int valorTiempo, String unidadTiempo) {
    final tiempoEnAnios = calcularTiempo(valorTiempo, unidadTiempo);
    return principal * (1 + (tasaInteres/100) * tiempoEnAnios);
  }

  static double calcularInteres(int principal, double tasaInteres, int valorTiempo, String unidadTiempo) {
    final tiempoEnAnios = calcularTiempo(valorTiempo, unidadTiempo);
    return (principal * (tasaInteres/100) * tiempoEnAnios);
  }

  static double calcularCapital(int interes, double tasaInteres, int valorTiempo, String unidadTiempo) {
    final tiempoEnAnios = calcularTiempo(valorTiempo, unidadTiempo);
    return interes / ((tasaInteres/100) * tiempoEnAnios);
  }

  static double calcularTasaInteres(double interes, int capital, int valorTiempo, String unidadTiempo) {
    final tiempoEnAnios = calcularTiempo(valorTiempo, unidadTiempo);
    return interes / (capital * tiempoEnAnios);
  }

  static double calcularTime(int interes, double tasaInteres, int capital) {
    // final tiempoEnAnios = calcularTiempo(valorTiempo, unidadTiempo);
    return interes / (capital * (tasaInteres/100));
  }

  static double calcularMontoFinalCompuesto(double principal, double tasaInteres, int valorTiempo, String unidadTiempo) {
    final tiempo = calcularTiempo(valorTiempo, unidadTiempo);
    return principal * pow((1 + (tasaInteres/100)), tiempo);
  }

  static List<double> calcularMonto(double capital, double tasaInteres, int valorTiempo, String unidadTiempo) {
    final tiempo = calcularTiempo(valorTiempo, unidadTiempo);
    List<double> capitalPorPeriodo = [];
    for (int i = 1; i <= tiempo; i++) {
    capital = capital * pow(1 + tasaInteres,1); 
    capitalPorPeriodo.add(capital);
  }
    return capitalPorPeriodo;
  }

  static double calcularCapitalCompuesto(int montofinal, double tasaInteres, int valorTiempo, String unidadTiempo) {
    final tiempo = calcularTiempo(valorTiempo, unidadTiempo);
    return montofinal / pow((1 + tasaInteres), tiempo);
  }

  static calcularTasainteresCompuesta(double montofinal, double capital, int valorTiempo, String unidadTiempo) {
    final tiempo = calcularTiempo(valorTiempo, unidadTiempo);
    return pow(montofinal/capital, 1/tiempo) -1 ;
  }

  static double calcularTimeCompuesto(double interes, double montofinal, double capital) {
    // final tiempoEnAnios = calcularTiempo(valorTiempo, unidadTiempo);
    return log( montofinal / capital ) / log( 1 + interes);
  }

  static double calcularCapitalizacionSimple(double principal, double tasaInteres, int valorTiempo, String unidadTiempo) {
    final tiempo = calcularTiempo(valorTiempo, unidadTiempo);
    return principal * tasaInteres * tiempo;
  }
  static double calcularCapitalizacionCompuesta(double principal, double tasaInteres, int valorTiempo, String unidadTiempo) {
    final tiempo = calcularTiempo(valorTiempo, unidadTiempo);
    return principal * pow(1 + tasaInteres, tiempo);
  }

  static Map<String, double> calcularSistemaAmericano(double principal, double tasaInteres, int valorTiempo, String unidadTiempo) {
    final tiempo = calcularTiempo(valorTiempo, unidadTiempo);
    final totalDevolver = principal * (1 + tasaInteres * tiempo);
    final interes = totalDevolver - principal;

    return {'totalDevolver': totalDevolver, 'interes': interes};
  }

  static Map<String, double> calcularSistemaFrances(double principal, double tasaInteres, double valorTiempo, String unidadTiempo) {
    final tiempo = calcularTiempoFrances(valorTiempo, unidadTiempo);
    final cuotaMensual = (principal * tasaInteres/12) /
        (1 - (pow(1 + tasaInteres/12, -tiempo))); // Fórmula del sistema francés

    final totalDevolver = cuotaMensual * tiempo;

    return {'cuotaMensual': cuotaMensual, 'totalDevolver': totalDevolver};
  }

  static List<Map<String, double>> calcularSistemaAleman(double principal, double tasaInteres, double valorTiempo, String unidadTiempo) {

    final tiempo = calcularTiempoFrances(valorTiempo, unidadTiempo);
    final double cuota = principal / tiempo;
    List<Map<String, double>> amortizacion = [];
    

    double balance = principal;

    for (int i = 0; i <= tiempo; i++) {
      double interesTotal = 0.0;
      double interes = balance * tasaInteres / 12;
      double capital = cuota + interes;
      balance -= cuota;
      for (int i = 0; i < amortizacion.length; i++) {
          interesTotal += amortizacion[i]['interes'] ?? 0.0;
      }
      amortizacion.add({'cuota': cuota, 'interes': interes,'interesTotal':interesTotal, 'capital': capital, 'balance': balance});
    }

    return amortizacion;
  }
}