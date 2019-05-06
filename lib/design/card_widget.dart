import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget body;
  final EdgeInsets padding;
  final List<Widget> actions;

  const CardWidget({Key key, this.body, this.padding, this.actions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.045),
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding,
            child: body,
          ),
          Padding(
            padding: EdgeInsets.only(left: padding.left, right: padding.right),
            child: Container(
              height: 1.0,
              color: Colors.black.withOpacity(0.035),
            ),
          ),
          Row(
            children: actions.map((action) => Expanded(child: action)).toList(),
          ),
        ],
      ),
    );
  }
}
