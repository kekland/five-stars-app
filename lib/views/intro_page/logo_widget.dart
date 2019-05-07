import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';

class TextLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Пять звёзд',
          style: ModernTextTheme.boldTitle.copyWith(fontSize: 36.0),
        ),
        Text(
          'транспорт и логистика',
          style: ModernTextTheme.caption.copyWith(fontSize: 18.0),
        ),
      ],
    );
  }
}

class IconLogoWidget extends StatelessWidget {
  final double size;

  const IconLogoWidget({Key key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(size / 2.0),
      ),
    );
  }
}
