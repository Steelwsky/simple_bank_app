import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_bank_app/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _loginTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserController userController = Provider.of<UserController>(context);
    return ValueListenableBuilder(
        valueListenable: userController.userStatus,
        builder: (_, user, __) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        user == UserStates.error
                            ? _userNotFound(context: context)
                            : SizedBox(height: 20),
                        _loginField(),
                        SizedBox(height: 20.0),
                        _passwordField(),
                        SizedBox(
                          height: 20.0,
                        ),
                        _logInButton(userController: userController),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _userNotFound({BuildContext context}) {
    return Container(
      height: 20,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Text(
          'User not found, please try again',
          style: TextStyle(fontSize: 16, color: Colors.redAccent),
        ),
      ),
    );
  }

  Widget _loginField() {
    return TextField(
      decoration: InputDecoration(labelText: "Login", hintText: 'admin'),
      keyboardType: TextInputType.text,
      controller: _loginTextController,

      // onChanged: (login) {},
    );
  }

  Widget _passwordField() {
    return TextField(
      decoration: InputDecoration(labelText: "Password", hintText: '0000'),
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordTextController,
      // onChanged: (password) {},
    );
  }

  Widget _logInButton({@required UserController userController}) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          userController.userCheck(
            login: _loginTextController.value.text,
            password: _passwordTextController.value.text,
          );
        },
        child: Text("Log in",
            textAlign: TextAlign.center,
            style: TextStyle(
                // color: Colors.white,
                // fontWeight: FontWeight.bold,
                )),
      ),
    );
  }
}
