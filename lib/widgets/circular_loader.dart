import 'package:flutter/material.dart';

class MyCircularIndicatorWidget extends StatefulWidget {
  @override
  _MyCircularIndicatorWidgetState createState() => _MyCircularIndicatorWidgetState();
}

class _MyCircularIndicatorWidgetState extends State<MyCircularIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    print('loader');
    return Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.pink),
          ),
        ));
  }
}
