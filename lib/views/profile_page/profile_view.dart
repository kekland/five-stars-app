import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ProfileViewWidget extends StatelessWidget {
  final User profile;

  const ProfileViewWidget({Key key, this.profile}) : super(key: key);
  
  static ListView buildAsListView({BuildContext context, User profile}) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        buildCard(
          child: TwoLineInformationWidget(
            title: "Имя пользователя",
            value: profile.username,
            icon: FontAwesomeIcons.userAlt,
            unit: "",
            iconColor: ModernTextTheme.captionIconColor,
          ),
        ),
        SizedBox(height: 16.0),
        buildCard(
          child: TwoLineInformationWidget(
            title: "Почта",
            value: profile.email,
            icon: FontAwesomeIcons.solidEnvelope,
            unit: "",
            iconColor: ModernTextTheme.captionIconColor,
          ),
        ),
        SizedBox(height: 16.0),
        buildCard(
          child: TwoLineInformationWidget(
            title: "Имя",
            value: "${profile.name}",
            icon: FontAwesomeIcons.userAlt,
            unit: "",
            iconColor: ModernTextTheme.captionIconColor,
          ),
        ),
        SizedBox(height: 16.0),
        buildCard(
          child: TwoLineInformationWidget(
            title: "Номер телефона",
            value: profile.phoneNumber,
            icon: FontAwesomeIcons.phone,
            unit: "",
            iconColor: ModernTextTheme.captionIconColor,
          ),
        ),
        SizedBox(height: 16.0),
        buildCard(
          child: TwoLineInformationWidget(
            title: "Организация",
            value: profile.organization,
            icon: FontAwesomeIcons.solidBuilding,
            unit: "",
            iconColor: ModernTextTheme.captionIconColor,
          ),
        ),
      ],
    );
  }

  static Widget buildCard({Widget child}) {
    return CardWidget(
      actions: [],
      body: child,
      padding: const EdgeInsets.all(16.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProfileViewWidget.buildAsListView(profile: profile, context: context);
  }
}
