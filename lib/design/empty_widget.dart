import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final VoidCallback onRefresh;
  final Color accentColor;

  const EmptyWidget({Key key, this.onRefresh, this.accentColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Нет грузов. Нажмите, чтобы обновить.', style: ModernTextTheme.caption),
              IconButton(
                  icon: Icon(Icons.refresh), onPressed: onRefresh, color: accentColor, iconSize: 24.0),
            ],
          ),
        ),
    );
  }
}