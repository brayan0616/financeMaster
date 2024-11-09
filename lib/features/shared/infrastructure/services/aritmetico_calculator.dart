import 'dart:math';

class AritmeticoCalculator {
  static Map<String, double> calcularCreciente(double seriePagos, double tasaInteres, double variacion, int nPeriodos) {
    double valorPresente = seriePagos * ((1 - pow((1 + tasaInteres), - nPeriodos)) / tasaInteres) + (variacion / tasaInteres) * (((1 - pow((1 + tasaInteres), - nPeriodos)) / tasaInteres) - (nPeriodos / pow((1 + tasaInteres), nPeriodos)));
    double valorFuturo = seriePagos * ((pow(1 + tasaInteres, nPeriodos) - 1) / tasaInteres) +
        (variacion / tasaInteres) *
            (((pow(1 + tasaInteres, nPeriodos) - 1) / tasaInteres) - nPeriodos);
    return {'valorPresente': valorPresente, 'valorFuturo': valorFuturo};
  }

  static Map<String, double> calcularDecreciente(double seriePagos, double tasaInteres, double variacion, int nPeriodos) {
    double valorPresente = seriePagos * ((1 - pow(1 + tasaInteres, -nPeriodos)) / tasaInteres) -
        (variacion / tasaInteres) *
            (((1 - pow(1 + tasaInteres, -nPeriodos)) / tasaInteres) - (nPeriodos / pow(1 + tasaInteres, nPeriodos)));
    double valorFuturo = seriePagos * ((pow(1 + tasaInteres, nPeriodos) - 1) / tasaInteres) -
        (variacion / tasaInteres) *
            (((pow(1 + tasaInteres, nPeriodos) - 1) / tasaInteres) - nPeriodos);
    return {'valorPresente': valorPresente, 'valorFuturo': valorFuturo};
  }

  static Map<String, double> calcularAnticipado(double seriePagos, double tasaInteres, double variacion, int nPeriodos) {
    double valorPresente = ((seriePagos * (1 - pow(1 + tasaInteres, -nPeriodos))) / tasaInteres) +
        (variacion / tasaInteres) *
            (((1 - pow(1 + tasaInteres, -nPeriodos)) / tasaInteres) - (nPeriodos / pow(1 + tasaInteres, nPeriodos))) *
            (1 + tasaInteres);
    double valorFuturo = ((seriePagos * (1 - pow(1 + tasaInteres, nPeriodos - 1))) / tasaInteres) +
        (variacion / tasaInteres) *
            (((1 - pow(1 + tasaInteres, nPeriodos - 1)) / tasaInteres) - nPeriodos) *
            (1 + tasaInteres);
    return {'valorPresente': valorPresente, 'valorFuturo': valorFuturo};
  }

  static Map<String, double> calcularVencido(double seriePagos, double tasaInteres, double variacion, int nPeriodos) {
    double valorPresente = seriePagos * ((1 - pow(1 + tasaInteres, -nPeriodos)) / tasaInteres) +
        (variacion / tasaInteres) *
            (((1 - pow(1 + tasaInteres, -nPeriodos)) / tasaInteres) - (nPeriodos / pow(1 + tasaInteres, nPeriodos)));
    double valorFuturo = seriePagos * ((pow(1 + tasaInteres, nPeriodos) - 1) / tasaInteres) +
        (variacion / tasaInteres) *
            (((pow(1 + tasaInteres, nPeriodos) - 1) / tasaInteres) - nPeriodos);
    return {'valorPresente': valorPresente, 'valorFuturo': valorFuturo};
  }

  static String obtenerFormulaValorPresente(String tipoGradiente) {
    switch (tipoGradiente) {
      case 'creciente':
        return r'VP=A\left[\frac{1-\left(1+i\right)^{-n}}{i}\right]+\frac{G}{i}\left[\frac{1-\left(1+i\right)^{-n}}{i}-\frac{n}{\left(1+i\right)^n}\right]';
      case 'decreciente':
        return r'VP=A\left[\frac{1-\left(1+i\right)^{-n}}{i}\right]-\frac{G}{i}\left[\frac{1-\left(1+i\right)^{-n}}{i}-\frac{n}{\left(1+i\right)^n}\right]';
      case 'anticipado':
        return r'P=\left[\frac{A\left[1-\left(1+i\right)^{-n}\right]}{i}+\left(\frac{G}{i}\right)\left[\frac{\left[1-\left(1+i\right)^{-n}\right]}{i}-\frac{n}{\left(1+i\right)^n}\right]\right]\left(1+i\right)';
      case 'vencido':
        return r'P=\frac{A\left[1-\left(1+i\right)^{-n}\right]}{i}+\left(\frac{G}{i}\right)\left[\frac{\left[1-\left(1+i\right)^{-n}\right]}{i}-\frac{n}{\left(1+i\right)^n}\right]';
      default:
        return '';
    }
  }

  static String obtenerFormulaValorFuturo(String tipoGradiente) {
    switch (tipoGradiente) {
      case 'creciente':
        return r'VF=A\left[\frac{\left(1+i\right)^n-1}{i}\right]+\frac{G}{i}\left[\frac{\left(1+i\right)^n-1}{i}-n\right]';
      case 'decreciente':
        return r'VF=A\left[\frac{\left(1+i\right)^n-1}{i}\right]-\frac{G}{i}\left[\frac{\left(1+i\right)^n-1}{i}-n\right]';
      case 'anticipado':
        return r'F=\left[\frac{A\left[\left(1+i\right)^n-1\right]}{i}+\left(\frac{G}{i}\right)\left[\frac{\left[\left(1+i\right)^n-1\right]}{i}-n\right]\right]\left(1+i\right)';
      case 'vencido':
        return r'F=\frac{A\left[\left(1+i\right)^n-1\right]}{i}+\left(\frac{G}{i}\right)\left[\frac{\left[\left(1+i\right)^n-1\right]}{i}-n\right]';
      default:
        return '';
    }
  }

}