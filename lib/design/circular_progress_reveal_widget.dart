import 'package:flutter/material.dart';

class CircularProgressRevealWidget extends StatelessWidget {
  final Color color;

  const CircularProgressRevealWidget({Key key, this.color = Colors.blue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.0,
      height: 64.0,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.045),
            offset: Offset(0.0, 2.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
