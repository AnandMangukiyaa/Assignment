import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_assignment/core/enums/enums.dart';
import 'package:flutter_assignment/core/helpers/helpers.dart';
import 'package:flutter_assignment/models/models.dart';
import 'package:flutter_assignment/services/services.dart';

class AuthenticationRepository {
  //


  Future<AuthResult> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      String? token = PreferencesService.pref!.getString("${email}Token");

      if(token != null && token.isNotEmpty){
        String pass = "${email}MyToken${password}";
        final jwt = JWT.verify(token, SecretKey(pass));

        return AuthResult(status: true, user: true);
      }else{
        PreferencesService.pref!.setString("email", email);
        PreferencesService.pref!.setString("password", password);
        String yourToken = "${email}MyToken${password}";
        final jwt = JWT(
          // Payload
          {
            'id': 123,
            'server': {
              'id': '3e4fc296',
              'loc': 'euw-2',
            }
          },
          issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
        );

// Sign it (default with HS256 algorithm)
        final token = jwt.sign(SecretKey(yourToken));
        PreferencesService.pref!.setString("${email}Token", token);

        return AuthResult(status: true, user: true);
      }
    }on JWTExpiredException {
      return AuthResult(status: false, user: false,message: "Unauthorized");
    } on JWTException catch (ex) {
      return AuthResult(status: false, user: false,message: ex.message); // ex: invalid signature
    } on Exception catch (e) {
      return AuthResult(status: false, user: false,message: e.toString());
    }
  }


}
