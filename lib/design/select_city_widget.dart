import 'package:five_stars/design/select_location_page.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectCityWidget extends StatelessWidget {
  final Function(City) onSelected;
  final City selectedCity;
  final String subtitle;
  final IconData icon;

  const SelectCityWidget(
      {Key key, this.onSelected, this.selectedCity, this.subtitle, this.icon})
      : super(key: key);

  void onClick(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => SelectLocationPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => onClick(context),
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TwoLineInformationWidgetExpanded(
                  title: subtitle,
                  value: 'Алма-Ата, Казахстан',
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: icon,
                  unit: "",
                ),
              ),
              Icon(
                FontAwesomeIcons.globeEurope,
                color: ModernTextTheme.captionIconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
