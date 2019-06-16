import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectVehicleType extends StatelessWidget {
  final VehicleType selectedVehicleType;
  final Function(VehicleType type) onSelect;

  const SelectVehicleType({Key key, this.selectedVehicleType, this.onSelect})
      : super(key: key);

  void showDialog(BuildContext context) {
    showModernDialog(
      context: context,
      title: 'Выберите тип кузова',
      body: Expanded(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: VehicleTypeUtils.vehicleTypeNames.keys.map((type) {
              return Material(
                borderRadius: BorderRadius.circular(8.0),
                type: MaterialType.transparency,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    onSelect(type);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          (selectedVehicleType == type)? Icons.radio_button_checked : Icons.radio_button_unchecked,
                          color: (selectedVehicleType == type)? Colors.indigo : Colors.grey,
                        ),
                        SizedBox(width: 12.0),
                        Expanded(
                          child: Text(
                            VehicleTypeUtils.vehicleTypeNames[type] ?? "xd",
                            style: ModernTextTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => showDialog(context),
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TwoLineInformationWidgetExpanded(
            iconColor: ModernTextTheme.captionIconColor,
            icon: FontAwesomeIcons.truckMoving,
            title: 'Тип кузова',
            value: selectedVehicleType != null? VehicleTypeUtils.vehicleTypeNames[selectedVehicleType] : "Не выбрано",
            unit: "",
          ),
        ),
      ),
    );
  }
}
