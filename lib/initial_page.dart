import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_bank_app/controller/login_controller.dart';
import 'package:simple_bank_app/pages/login_page.dart';

import 'file:///C:/Users/zadorskiy.vi/Desktop/Android/flutter/simple_bank_app/lib/pages/home_page.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LogInController logInController = Provider.of<LogInController>(context);
    return MultiProvider(
        providers: [
          Provider<UserController>(create: (_) => UserController(logInController: logInController)),
        ],
        child: ValueListenableBuilder(
            valueListenable: logInController.isLoggedIn,
            builder: (_, isLoggedIn, __) {
              if (isLoggedIn) {
                return MyHomePage();
              } else
                return LoginPage();
            }));
  }
}
