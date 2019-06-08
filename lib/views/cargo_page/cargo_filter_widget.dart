import 'package:expandable/expandable.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/divider_widget.dart';
import 'package:five_stars/design/stadium_switch_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/filter/bounded.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CargoFilterOptions {
  Bounded volume;
  Bounded weight;
  Bounded price;
  List<VehicleType> vehicleTypes;

  CargoFilterOptions({this.volume, this.weight, this.price, this.vehicleTypes});
}

class CargoFilterWidget extends StatefulWidget {
  @override
  _CargoFilterWidgetState createState() => _CargoFilterWidgetState();
}

class _CargoFilterWidgetState extends State<CargoFilterWidget> {
  CargoFilterOptions options = CargoFilterOptions(
    volume: Bounded(lower: 0.0, upper: 1000.0),
    price: Bounded(lower: 0.0, upper: 1000000.0),
    weight: Bounded(lower: 0.0, upper: 10000.0),
    vehicleTypes: List.from(VehicleType.values),
  );
  @override
  Widget build(BuildContext context) {
    return CardWidget(
      padding: EdgeInsets.zero,
      body: ExpandablePanel(
        iconPlacement: ExpandablePanelIconPlacement.right,
        initialExpanded: false,

        header: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Text('Фильтр', style: ModernTextTheme.primaryAccented),
        ),
        hasIcon: false,
        collapsed: SizedBox(width: double.infinity),
        expanded: buildExpanded(),
        tapBodyToCollapse: false,
        tapHeaderToExpand: true,
      ),
    );
  }

  Widget buildExpanded() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 8.0),
          BoundedRangeWidget(
            title: 'Объём (м³)',
            unit: 'м³',
            bounds: options.volume,
            onChange: (Bounded newBounds) =>
                setState(() => options.volume = newBounds),
            maximumBound: 1000.0,
            divisions: 20,
            color: Colors.purple,
            colorLight: Colors.purple.shade300,
            colorDark: Colors.purple.shade600,
            icon: FontAwesomeIcons.cube,
          ),
          SizedBox(height: 24.0),
          BoundedRangeWidget(
            title: 'Вес (кг.)',
            unit: 'кг.',
            bounds: options.weight,
            onChange: (Bounded newBounds) =>
                setState(() => options.weight = newBounds),
            maximumBound: 10000.0,
            divisions: 25,
            color: Colors.purple,
            colorLight: Colors.purple.shade300,
            colorDark: Colors.purple.shade600,
            icon: FontAwesomeIcons.weightHanging,
          ),
          DividerWidget(),
          Text('Тип кузова', style: ModernTextTheme.primaryAccented),
          SizedBox(height: 16.0),
          Wrap(
            spacing: 4.0,
            runSpacing: 8.0,
            alignment: WrapAlignment.start,
            children: VehicleTypeUtils.vehicleTypeNames.keys
                .map((type) => StadiumSwitchWidget(
                      checked: (options.vehicleTypes.contains(type)),
                      color: Colors.purple,
                      backgroundColor: Colors.purple.shade50,
                      title: VehicleTypeUtils.vehicleTypeNames[type],
                      onToggle: () {
                        print(type.toString());
                        print(options.vehicleTypes.contains(type));
                        if (options.vehicleTypes.contains(type)) {
                          options.vehicleTypes.remove(type);
                        } else {
                          options.vehicleTypes.add(type);
                        }
                        setState(() {});
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
