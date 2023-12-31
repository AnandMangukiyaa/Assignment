part of 'helpers.dart';

mixin ValidationMixin {
  //
  String? nameValidation(String? name) {
    if (name!.isNotEmpty) {
      return null;
    } else {
      return 'Please enter name';
    }
  }

  String? emailAddressValidation(String? email) {
    if (email!.isNotEmpty) {
      if (isEmailValid(email)) {
        return null;
      } else {
        return 'Enter valid Email address';
      }
    } else {
      return 'Please enter email address';
    }
  }

  String? passwordValidation(String? value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else if (value!.length < 8 ) {
      return 'Password must be at least 8 characters long';
    }else {
      if (!regex.hasMatch(value)) {
        return 'Password must be contains at least one symbol,number and capital latter';
      } else {
        return null;
      }
    }
  }

  String? newPasswordValidation(String? value, String? currentPassword) {
    if (value!.isEmpty) {
      return 'Please enter new password';
    } else {
      if (value.length < 6) {
        return 'Password must be at least 6 characters long';
      } else {
        if (currentPassword != null) {
          if (value == currentPassword) {
            return 'New password must be different from current password';
          } else {
            return null;
          }
        } else {
          return null;
        }
      }
    }
  }

  String? confirmPasswordValidation(String? value, String password) {
    if (value!.isEmpty) {
      return 'Please re-enter password';
    } else {
      if (password != value) {
        return 'Password does not match';
      }
    }
    return null;
  }

  String? genderValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please select gender';
    }
    return null;
  }

  String? statusValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please select status';
    }
    return null;
  }

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
