import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_bank_app/controller/page_controller.dart';
import 'package:simple_bank_app/initial_page.dart';
import 'controller/login_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final LogInController logInController = LogInController();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LogInController>(
          create: (_) => LogInController(),
        ),
        Provider<MyPageController>(
          create: (_) => MyPageController(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: InitialPage(),
      ),
    );
  }
}
