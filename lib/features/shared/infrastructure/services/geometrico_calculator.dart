import 'dart:math';

class GeometricoCalculator {
  static Map<String, double> calcularCreciente(double seriePagos, double tasaInteres, double variacion, int nPeriodos) {
    double valorPresente = (seriePagos * ((pow((1 - variacion), nPeriodos) * pow((1 + tasaInteres), -nPeriodos) - 1)) / (variacion - tasaInteres));
    double valorFuturo = (seriePagos * ((pow((1 + variacion), nPeriodos) - pow((1 + tasaInteres), nPeriodos))) / (variacion - tasaInteres));
    return {'valorPresente': valorPresente, 'valorFuturo': valorFuturo};
  }

  static Map<String, double> calcularDecreciente(double seriePagos, double tasaInteres, double variacion, int nPeriodos) {
    double valorPresente = (seriePagos * (1 - (pow((1 - variacion), nPeriodos) * pow((1 + tasaInteres), -nPeriodos)))) / (variacion + tasaInteres);
    double valorFuturo = (seriePagos * ((pow((1 + tasaInteres), nPeriodos) - pow((1 - variacion), nPeriodos))) / (variacion + tasaInteres));
    return {'valorPresente': valorPresente, 'valorFuturo': valorFuturo};
  }

  static String obtenerFormulaValorPresente(String tipoGradiente) {
    switch (tipoGradiente) {
      case 'creciente':
        return r'VP=\left[\frac{A\left[\left(1+G\right)^n\left(1+i\right)^{-n}-1\right]}{G-1}\right]';
      case 'decreciente':
        return r'VP=\left[\frac{A\left[1-\left(1-G\right)^n\left(1+i\right)^{-n}\right]}{G+i}\right]';
      default:
        return '';
    }
  }

  static String obtenerFormulaValorFuturo(String tipoGradiente) {
    switch (tipoGradiente) {
      case 'creciente':
        return r'VF=\left[\frac{A\left[\left(1+G\right)^n-\left(1+i\right)^n\right]}{G-i}\right]';
      case 'decreciente':
        return r'VF=\left[\frac{A\left[\left(1+i\right)^n-\left(1-G\right)^n\right]}{G+i}\right]';
      default:
        return '';
    }
  }

}