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

  Future<void> createUser(UserData user) async {
    // return collections.userDoc(user.userId ?? '').set(user.toMap());
  }

  Future<List<UserData>> getUsers() async{
    try{
      Result response = await _http.request(requestType: RequestType.get, url: "${ApiUrls.baseUrl}${ApiUrls.getUsers}");
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
