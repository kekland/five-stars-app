import 'package:five_stars/design/select_location_page.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectCityWidget extends StatelessWidget {
  final Function(City) onSelected;
  final City selectedCity;
  final String subtitle;
  final IconData icon;
  final bool showGlobeIcon;

  const SelectCityWidget(
      {Key key,
      this.onSelected,
      this.selectedCity,
      this.subtitle,
      this.icon,
      this.showGlobeIcon = true})
      : super(key: key);

  void onClick(BuildContext context) async {
    await checkForLocationPermission();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SelectLocationPage(
            selectedCity: selectedCity, onSelected: onSelected)));
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
                  value: selectedCity?.name ?? "Не выбрано",
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: icon,
                  unit: "",
                ),
              ),
              if (showGlobeIcon)
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
