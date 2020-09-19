import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_bank_app/controller/page_controller.dart';
import 'package:simple_bank_app/models/nav_bar_model.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final BottomNavBarItems myBottomNavBarItems = BottomNavBarItems();

  @override
  Widget build(BuildContext context) {
    final myPageController = Provider.of<MyPageController>(context);
    return ValueListenableBuilder<int>(
        valueListenable: myPageController.pageStateNotifier,
        builder: (_, pageState, __) {
          return BottomNavigationBar(
              items: [
                ...myBottomNavBarItems.tabs.map((tab) => BottomNavigationBarItem(
                      title: Text(tab.name),
                      icon: tab.icon,
                    )),
              ],
              currentIndex: pageState,
              onTap: (index) {
                myPageController.pageNavBarChange(index);
              });
        });
  }
}
