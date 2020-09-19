import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_bank_app/controller/page_controller.dart';
import 'package:simple_bank_app/widgets/bottom_nav_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget build(BuildContext context) {
    final MyPageController myPageController = Provider.of<MyPageController>(context);
    return ValueListenableBuilder<int>(
      valueListenable: myPageController.pageStateNotifier,
      builder: (_, pageIndex, __) {
        return Scaffold(
          body: myPageController.pages[pageIndex],
          bottomNavigationBar: CustomBottomNavigationBar(),
        );
      },
    );
  }
}
