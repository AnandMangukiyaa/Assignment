import 'dart:convert';
import 'dart:io';

import 'package:flutter_assignment/core/constants/constants.dart';
import 'package:flutter_assignment/core/enums/enums.dart';
import 'package:flutter_assignment/core/helpers/helpers.dart';
import 'package:flutter_assignment/models/models.dart';
import 'package:flutter_assignment/repositories/authentication_repository.dart';
import 'package:flutter_assignment/services/services.dart';

class UserRepository {
  final AuthenticationRepository auth;

  UserRepository({required this.auth});
  final HttpService _http = HttpService();

  Future<bool> createUser(UserData user) async {
    try{
      String params = jsonEncode(user.toJson());
      Result response = await _http.request(requestType: RequestType.post, url: "${ApiUrls.baseUrl}${ApiUrls.getUsers}",parameter: params);
      if(response is Success){
        return true;
      }else{
        return false;
      }
    }catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(UserData user) async {
    try{
      String params = jsonEncode(user.toupdateJson());
      String url = "${ApiUrls.baseUrl}${ApiUrls.getUsers}/${user.id!}";
      Result response = await _http.request(requestType: RequestType.patch, url: url,parameter: params);
      if(response is Success){
        return true;
      }else{
        return false;
      }
    }catch (e) {
      return false;
    }
  }

  Future<List<UserData>> getUsers(int page) async{
    try{
      Result response = await _http.request(requestType: RequestType.get, url: "${ApiUrls.baseUrl}${ApiUrls.getUsers}?page=$page&per_page=20");
      if(response is Success){
          return userDataFromJson(response.value);
      }else{
        return Future(() => List<UserData>.empty());
      }
    }catch (e) {
      return Future(() => List<UserData>.empty());
    }
  }




}
