import 'package:flutter/material.dart';

enum UserStates { none, success, error }

class UserController {
  UserController({@required this.logInController});
  final LogInController logInController;

  ValueNotifier<UserStates> userStatus = ValueNotifier(UserStates.none);

  bool userCheck({@required String login, @required String password}) {
    print('userCheck');
    if (login == 'admin' && password == '0000') {
      print('userCheck: success');
      logInController.isLoggedIn.value = true;
      userStatus.value = UserStates.success;
      return true;
    } else {
      print('userCheck: error');
      userStatus.value = UserStates.error;
      return false;
    }
  }
}

class LogInController {
  ValueNotifier<bool> isLoggedIn = ValueNotifier(false);
}
