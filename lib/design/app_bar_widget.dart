import 'package:five_stars/design/shadows/shadows.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final Widget title;
  final Widget action;
  final bool includeBackButton;
  final Color accentColor;

  const AppBarWidget({Key key, this.title, this.action, this.includeBackButton = false, this.accentColor = Colors.pink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64.0,
      decoration: BoxDecoration(
        color: ModernColorTheme.main,
        boxShadow: [Shadows.slightShadow],
      ),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          if (includeBackButton)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: accentColor,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          Align(
            alignment: Alignment.center,
            child: DefaultTextStyle.merge(
              style: ModernTextTheme.boldTitle.copyWith(color: Colors.white),
              child: title,
            ),
          ),
          if (action != null)
            Align(
              alignment: Alignment.centerRight,
              child: action,
            ),
        ],
      ),
    );
  }
}

class AppBarBottomWidget extends StatelessWidget {
  final Widget title;

  const AppBarBottomWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [Shadows.slightShadowTop],
      ),
      alignment: Alignment.center,
      child: DefaultTextStyle.merge(
        style: ModernTextTheme.boldTitle,
        child: title,
      ),
    );
  }
}
