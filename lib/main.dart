import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_bank_app/controller/page_controller.dart';
import 'package:simple_bank_app/controller/transaction_controller.dart';
import 'package:simple_bank_app/initial_page.dart';
import 'package:simple_bank_app/storage/storage_concept.dart';

import 'controller/login_controller.dart';

/* todo redux?
* */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final CloudStorage myDatabase = MyDatabase();
  runApp(MyApp(
    myDatabase: myDatabase,
  ));
}

class MyApp extends StatefulWidget {
  MyApp({this.myDatabase});

  final CloudStorage myDatabase;

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
        Provider<TransactionController>(
            create: (_) => TransactionController(myDatabase: widget.myDatabase)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          accentColor: Colors.pink,
          cursorColor: Colors.pink,
          accentColorBrightness: Brightness.dark,
          brightness: Brightness.dark,
          focusColor: Colors.pink,
          textSelectionHandleColor: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: InitialPage(),
      ),
    );
  }
}
