
import 'package:flutter_assignment/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_assignment/blocs/images/images_bloc.dart';
import 'package:flutter_assignment/blocs/user/user_bloc.dart';
import 'package:flutter_assignment/repositories/authentication_repository.dart';
import 'package:flutter_assignment/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

class Injector {
  Injector._();

  static void init() {
    // Repositories
    GetIt.I.registerFactory(() => AuthenticationRepository());
    GetIt.I.registerFactory(() => ImagesBloc());
    GetIt.I.registerFactory(() {
      return UserRepository( auth: GetIt.I());
    });

    // Blocs
    GetIt.I.registerFactory(() {
      return AuthenticationBloc(
        authenticationRepository: GetIt.I(),
        userRepository: GetIt.I(),
      );
    });
    GetIt.I.registerFactory(() {
      return UserBloc(userRepository: GetIt.I());
    });
  }
}
