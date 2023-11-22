import 'dart:io';

import 'package:flutter_assignment/core/enums/enums.dart';
import 'package:flutter_assignment/models/models.dart';
import 'package:flutter_assignment/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserBloc extends Cubit<UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(const UserState());

  getUsers() async{
    try {
      emit(state.update(status: ResultStatus.loading));
      List<UserData> users = await userRepository.getUsers();
      emit(state.update(users: users,status: ResultStatus.success));
    } catch (e) {
      print(e);
      emit(state.update(message: "Something went wrong",status: ResultStatus.failure));
    }
  }





}
