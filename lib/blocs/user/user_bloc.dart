import 'dart:io';

import 'package:flutter_assignment/core/enums/enums.dart';
import 'package:flutter_assignment/models/models.dart';
import 'package:flutter_assignment/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_assignment/services/services.dart';

part 'user_state.dart';

class UserBloc extends Cubit<UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(const UserState());
  List<UserData> users = [];

  int page = 1;

  getUsers() async{
    try {
      if(await ConnectivityService.isConnected) {
        emit(state.update(status: ResultStatus.loading));
        List<UserData> users = await userRepository.getUsers(page);
        this.users.addAll(users);
        if (users.isNotEmpty) {
          page++;
          emit(state.update(users: this.users, status: ResultStatus.success));
        } else {
          emit(state.update(
              message: "Something went wrong", status: ResultStatus.failure));
        }
      }else{
        emit(state.update(
            message: "Check your internet connection", status: ResultStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.update(message: "Something went wrong",status: ResultStatus.failure));
    }
  }

  createUser(UserData user) async{
    try {
      if(await ConnectivityService.isConnected) {
        emit(state.update(status: ResultStatus.loading));
      bool created = await userRepository.createUser(user);
      // if(created) {
        emit(state.update(users: [],status: ResultStatus.success));
      /*}else{
        emit(state.update(message: "Something went wrong",status: ResultStatus.failure));
      }*/
      }else{
        emit(state.update(
            message: "Check your internet connection", status: ResultStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.update(message: "Something went wrong",status: ResultStatus.failure));
    }
  }

  updateUser(UserData user) async{
    try {
      if(await ConnectivityService.isConnected) {
        emit(state.update(status: ResultStatus.loading));
      bool updated = await userRepository.updateUser(user);
      if(updated) {
        emit(state.update(users: [],status: ResultStatus.success));
      }else{
        emit(state.update(message: "Something went wrong",status: ResultStatus.failure));
      }
      }else{
        emit(state.update(
            message: "Check your internet connection", status: ResultStatus.failure));
      }
    } catch (e) {
      print(e);
      emit(state.update(message: "Something went wrong",status: ResultStatus.failure));
    }
  }







}
