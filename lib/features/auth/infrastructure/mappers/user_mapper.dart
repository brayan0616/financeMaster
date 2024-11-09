
import 'package:teslo_shop/features/auth/domain/domain.dart';


class UserMapper {


  static User userJsonToEntity( Map<String,dynamic> json ) {
    final userJson = json['user'];

    return User(
      id: userJson['id'],
      email: userJson['email'],
      fullName: userJson['name'],
      token: json['token']
    );

  }

}

