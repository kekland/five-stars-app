import 'package:flutter/material.dart';

class PageHeaderWidget extends StatelessWidget {
  final String title;

  const PageHeaderWidget({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}