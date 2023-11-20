import 'dart:io';

import 'package:flutter_assignment/core/helpers/helpers.dart';
import 'package:flutter_assignment/models/models.dart';
import 'package:flutter_assignment/repositories/authentication_repository.dart';

class UserRepository {
  final AuthenticationRepository auth;

  UserRepository({required this.auth});

  Future<void> createUser(UserData user) async {
    // return collections.userDoc(user.userId ?? '').set(user.toMap());
  }

  Stream<UserData> userStream() {
    /*User? user = auth.user;
    if (user != null) {
      return collections.userDoc(user.uid).snapshots().map((doc) {
        return UserData.fromMap(doc.data() as Map<String, dynamic>);
      });
    } else {
      return const Stream.empty();
    }*/
    return const Stream.empty();
  }

  Stream<UserData> getUserById(String? userId) {
    // return collections.userDoc(userId).snapshots().map((doc) {
    //   return UserData.fromMap(doc.data() as Map<String, dynamic>);
    // });
    return const Stream.empty();
  }


}
