import 'package:formz/formz.dart';

// Define input validation errors
enum TasaInteresError { empty, value , format }

// Extend FormzInput and provide the input type and error type.
class TasaInteres extends FormzInput<double, TasaInteresError> {


  static final RegExp tasaInteresRegExp = RegExp(
    r'^\d+(\.\d+)?$',
  );

  // Call super.pure to represent an unmodified form input.
  const TasaInteres.pure() : super.pure(0.0);

  // Call super.dirty to represent a modified form input.
  const TasaInteres.dirty( double value ) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == TasaInteresError.empty ) return 'El campo es requerido';
    if ( displayError == TasaInteresError.value ) return 'Debe ser mayor o igual a 1';
    if ( displayError == TasaInteresError.format ) return 'Solo debe de ser numeros';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  TasaInteresError? validator(double value) {

    if ( value == 0.0 ) return TasaInteresError.empty;
    if ( value < 1 ) return TasaInteresError.value;
    if ( !tasaInteresRegExp.hasMatch(value.toString()) ) return TasaInteresError.format;

    return null;
  }
}