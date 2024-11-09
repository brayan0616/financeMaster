import 'package:formz/formz.dart';

// Define input validation errors
enum TiempoError { empty,value ,format }

// Extend FormzInput and provide the input type and error type.
class Tiempo extends FormzInput<int, TiempoError> {


  static final RegExp tiempoRegExp = RegExp(
    r'^[0-9]+$',
  );

  // Call super.pure to represent an unmodified form input.
  const Tiempo.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const Tiempo.dirty( int value ) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == TiempoError.empty ) return 'El campo es requerido';
    if ( displayError == TiempoError.format ) return 'Solo debe de ser numeros';
    if ( displayError == TiempoError.value ) return 'El valor no puede ser negativo';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  TiempoError? validator(int value) {

    if ( value == 0 ) return TiempoError.empty;
    if ( value < 0 ) return TiempoError.value;
    if ( !tiempoRegExp.hasMatch(value.toString()) ) return TiempoError.format;

    return null;
  }
}