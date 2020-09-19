import 'package:flutter/material.dart';
import 'package:simple_bank_app/models/nav_bar_model.dart';
import 'package:simple_bank_app/pages/diagram_page.dart';
import 'package:simple_bank_app/pages/transations_page.dart';

class MyPageController extends BottomNavBarItems {
  ValueNotifier<int> pageStateNotifier = ValueNotifier(0);

  MyPageController() {
    print('pageController');
  }

  final List<Widget> pages = [
    TransactionsPage(),
    DiagramPage(),
  ];

  void pageNavBarChange(int pageIndex) async {
    pageStateNotifier.value = pageIndex;
  }
}
