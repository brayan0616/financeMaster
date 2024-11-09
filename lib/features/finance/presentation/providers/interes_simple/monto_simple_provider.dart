
import 'package:formz/formz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/inputs.dart';

part 'monto_simple_provider.g.dart';

enum TiempoType { dia, semana, mes,bimestral, trimestral,semestral,anual,compuesto}


@riverpod
class TiempoFilter extends _$TiempoFilter {
  @override
   TiempoType build() => TiempoType.dia;


   void changeCurrentFilter(TiempoType filter) {
    state = filter; 
  }
}


@riverpod
class MontoSimpleFormNotifier extends _$MontoSimpleFormNotifier {
  @override
  MontoSimpleState build() {
    return MontoSimpleState();
  }

  onCapitalChange( int value ) {
    final newCapital = Capital.dirty(value);
    state = state.copyWith(
      capital: newCapital,
      isValid: Formz.validate([ newCapital, state.tiempo, state.interes ])
    );
  }

  onTiempoChange( int value ) {
    final newTiempo = Tiempo.dirty(value);
    state = state.copyWith(
      tiempo: newTiempo,
      isValid: Formz.validate([ newTiempo, state.capital, state.interes ])
    );
  }

  onInteresChange( double value ) {
    final newInteres = TasaInteres.dirty(value);
    state = state.copyWith(
      interes: newInteres,
      isValid: Formz.validate([ newInteres, state.capital, state.tiempo ])
    );
  }

  onFormSubmitted() {
    _touchEveryField();
  }

  _touchEveryField() {
    final capital = Capital.dirty(state.capital.value);
    final tiempo = Tiempo.dirty(state.tiempo.value);
    final interes = TasaInteres.dirty(state.interes.value);

    state = state.copyWith(
      capital: capital,
      tiempo: tiempo,
      interes: interes,
      isValid: Formz.validate([ capital, tiempo, interes ])
    );
  }

  void clearForm() {
    state = MontoSimpleState();
  }
}

class MontoSimpleState {
  final Capital capital;
  final Tiempo tiempo;
  final TasaInteres interes;
  final bool isValid;


  MontoSimpleState({
    this.capital = const Capital.pure(),
    this.tiempo = const Tiempo.pure(),
    this.interes = const TasaInteres.pure(),
    this.isValid = false,

  });

  MontoSimpleState copyWith({
    Capital? capital,
    Tiempo? tiempo,
    TasaInteres? interes,
    bool? isValid

  }) {
    return MontoSimpleState(
      capital: capital ?? this.capital,
      tiempo: tiempo ?? this.tiempo,
      interes: interes ?? this.interes,
      isValid: isValid ?? this.isValid
    );
  }

  @override
  String toString() {
    return '''
      capital: $capital,
      tiempo: $tiempo,
      interes: $interes,
      isValid: $isValid
    ''';
  }
  
}