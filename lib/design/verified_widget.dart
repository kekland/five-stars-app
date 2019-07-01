import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerifiedWidgetExpanded extends StatelessWidget {
  final bool verified;

  const VerifiedWidgetExpanded({Key key, this.verified}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleLineInformationWidget(
      icon: (verified) ? Icons.check : FontAwesomeIcons.times,
      label: (verified) ? "Подтверждён" : "Не подтверждён",
      color: (verified) ? Colors.green : Colors.red,
    );
  }
}

class VerifiedWidgetInline extends StatelessWidget {
  final bool verified;

  const VerifiedWidgetInline({Key key, this.verified}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleLineInformationWidgetInline(
      icon: (verified) ? Icons.check : FontAwesomeIcons.times,
      label: (verified) ? "Подтверждён" : "Не подтверждён",
      color: (verified) ? Colors.green : Colors.red,
    );
  }
}
