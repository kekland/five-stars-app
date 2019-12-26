import 'package:five_stars/api/api.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      physics: const BouncingScrollPhysics(),
      children: [
        CardWidget(
          actions: [],
          body: SingleLineInformationWidget(
            icon: Icons.exit_to_app,
            label: 'Выйти из профиля',
            color: ModernColorTheme.main,
          ),
          padding: const EdgeInsets.all(16.0),
          onTap: () => Api.logOut(context),
        ),
      ],
    );
  }
}
