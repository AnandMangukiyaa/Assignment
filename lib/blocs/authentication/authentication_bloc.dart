import 'package:flutter_assignment/core/enums/enums.dart';
import 'package:flutter_assignment/core/helpers/helpers.dart';
import 'package:flutter_assignment/models/models.dart';
import 'package:flutter_assignment/repositories/authentication_repository.dart';
import 'package:flutter_assignment/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Cubit<AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  AuthenticationBloc({
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(const AuthenticationState());


  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(state.update(status: ResultStatus.loading));

    AuthResult result = await authenticationRepository
        .signInWithEmailAndPassword(email: email, password: password);

    if (result.status) {
      // String? deviceToken = await MessagingService.getToken();
      // userRepository.updateUserField(FirestoreFields.password, password);
      // userRepository.updateUserField(FirestoreFields.deviceToken, deviceToken);
      emit(state.update(status: ResultStatus.success, message: 'Logged in...'));
    } else {
      emit(state.update(status: ResultStatus.failure, message: result.message));
    }
  }



  void _authFailedResult(String message) {
    print("Auth fail resone --> ${message}");
    emit(
      state.update(
          status: ResultStatus.failure, message: 'Authentication failed'),
    );
  }

  Future<void> _clearAuth() async {
    //await authenticationRepository.signOut();
  }
}
