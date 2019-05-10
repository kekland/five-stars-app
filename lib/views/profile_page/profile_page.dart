import 'package:five_stars/controllers/profile_page_controller.dart';
import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends Presenter<ProfilePage, ProfilePageController> {
  @override
  void initController() {
    controller = ProfilePageController(presenter: this);
  }

  @override
  Widget present(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          AppBarWidget(
            title: Text('Личный кабинет'),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CardWidget(
                    padding: const EdgeInsets.all(32.0),
                    body: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TwoLineInformationWidgetExpanded(
                          title: 'ФИО',
                          value: 'Кабдыкайыров Ержан Кабижанулjjjjjы',
                          unit: '',
                          icon: FontAwesomeIcons.solidUser,
                          iconColor: ModernTextTheme.captionIconColor,
                        ),
                        SizedBox(height: 32.0),
                        TwoLineInformationWidgetExpanded(
                          title: 'Номер телефона',
                          value: '+77006532708',
                          unit: '',
                          icon: FontAwesomeIcons.phone,
                          iconColor: ModernTextTheme.captionIconColor,
                        ),
                        SizedBox(height: 32.0),
                        TwoLineInformationWidgetExpanded(
                          title: 'Город',
                          value: 'Алматы',
                          unit: '',
                          icon: FontAwesomeIcons.city,
                          iconColor: ModernTextTheme.captionIconColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
