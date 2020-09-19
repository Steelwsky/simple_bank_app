import 'dart:collection';

import 'package:flutter/material.dart';

class BottomNavBarItemModel {
  BottomNavBarItemModel({this.name, this.icon});

  final String name;
  final Icon icon;
}

class BottomNavBarItems {
  List<BottomNavBarItemModel> _tabs;

  BottomNavBarItems() {
    _tabs = [
      BottomNavBarItemModel(
          name: 'Overview',
          icon: Icon(
            Icons.home,
          )),
      BottomNavBarItemModel(
          name: 'Diagram',
          icon: Icon(
            Icons.pie_chart,
          )),
    ];
  }

  UnmodifiableListView<BottomNavBarItemModel> get tabs => UnmodifiableListView(_tabs);
}
