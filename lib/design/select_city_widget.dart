import 'package:five_stars/api/geocoding.dart';
import 'package:five_stars/design/select_location_page.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
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

  void onSelectMap(BuildContext context) async {
    await checkForLocationPermission();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SelectLocationPage(
            selectedCity: selectedCity, onSelected: onSelected)));
  }

  void onClick(BuildContext context) async {
    /*await checkForLocationPermission();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SelectLocationPage(
            selectedCity: selectedCity, onSelected: onSelected)));*/

    TextEditingController controller = TextEditingController(
      text: (selectedCity != null) ? selectedCity.name.toString() : '',
    );
    City selectedSuggestion = selectedCity;

    City returnValue = await showModernDialog<City>(
      context: context,
      title: 'Выберите значение',
      body: StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: controller,
                  decoration: InputDecoration(
                    fillColor: ModernTextTheme.captionIconColor,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.05), width: 2.0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.05), width: 2.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(width: 16.0),
                        Icon(icon),
                        SizedBox(width: 16.0),
                      ],
                    ),
                    hintText: 'Выберите город',
                    hintStyle: ModernTextTheme.caption,
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  final result = await GeoApi.geocoding(pattern);
                  return result;
                },
                onSuggestionSelected: (suggestion) {
                  controller.text = suggestion.name;
                  selectedSuggestion = suggestion;
                  setState(() {});
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion.name),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  child: Text('Выбрать на карте'),
                  textColor: Colors.purple,
                  onPressed: () {
                    Navigator.pop(context);
                    onSelectMap(context);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      child: Text('Отмена'),
                      onPressed: () => Navigator.of(context).pop()),
                  FlatButton(
                    child: Text('Выбрать'),
                    textColor: Colors.indigo,
                    onPressed: (selectedSuggestion != null)
                        ? () => Navigator.of(context).pop(selectedSuggestion)
                        : null,
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
    if (returnValue != null) {
      onSelected(returnValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => onClick(context),
        borderRadius: BorderRadius.circular(12.0),
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
