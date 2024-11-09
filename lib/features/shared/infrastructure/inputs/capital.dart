import 'package:formz/formz.dart';

// Define input validation errors
enum CapitalError { empty,value ,format }

// Extend FormzInput and provide the input type and error type.
class Capital extends FormzInput<int, CapitalError> {


  static final RegExp capitalRegExp = RegExp(
    r'^[0-9]+$',
  );

  // Call super.pure to represent an unmodified form input.
  const Capital.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const Capital.dirty( int value ) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == CapitalError.empty ) return 'El campo es requerido';
    if ( displayError == CapitalError.format ) return 'Solo debe de ser numeros';
    if ( displayError == CapitalError.value ) return 'El valor no puede ser negativo';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  CapitalError? validator(int value) {

    if ( value.toString().isEmpty || value.toString().trim().isEmpty ) return CapitalError.empty;
    if ( value < 0 ) return CapitalError.value;
    if ( !capitalRegExp.hasMatch(value.toString()) ) return CapitalError.format;

    return null;
  }
}