import 'package:flutter/material.dart';

class CircularProgressRevealWidget extends StatelessWidget {
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
      child: CircularProgressIndicator(),
    );
  }
}
