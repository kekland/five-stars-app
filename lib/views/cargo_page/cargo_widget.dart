import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/divider_widget.dart';
import 'package:five_stars/design/transparent_route.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/arrival_destination_widget.dart';
import 'package:five_stars/views/cargo_page/cargo_expanded_widget.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CargoWidget extends StatefulWidget {
  final Cargo data;
  final String heroPrefix;
  final bool addButtons;

  final Function(Cargo) onCargoEdited;
  final VoidCallback onCargoDeleted;
  final BuildContext context;

  const CargoWidget(
      {Key key, this.data, this.addButtons = true, this.heroPrefix = "", this.onCargoEdited, this.onCargoDeleted, this.context})
      : super(key: key);

  @override
  _CargoWidgetState createState() => _CargoWidgetState();
}

class _CargoWidgetState extends State<CargoWidget> {
  bool isExpanded = false;
  Size sizedBoxSize;

  void expand(BuildContext context) async {
    if (!widget.addButtons) {
      return;
    }

    setState(() {
      isExpanded = true;
      sizedBoxSize = context.size;
    });

    await Navigator.of(context).push(
      TransparentRoute(
        builder: (context) {
          return CargoExpandedWidget(
            data: widget.data,
            heroPrefix: widget.heroPrefix,
            context: widget.context,
            onCargoDeleted: widget.onCargoDeleted,
            onCargoEdited: widget.onCargoEdited,
          );
        },
      ),
    );

    await Future.delayed(Duration(milliseconds: 284));

    setState(() {
      isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "${widget.heroPrefix}_cargo_${this.widget.data.id}",
      flightShuttleBuilder:
          (context, animation, direction, context1, context2) {
        return CargoWidget(data: widget.data, addButtons: true);
      },
      child: (isExpanded)
          ? SizedBox(
              width: sizedBoxSize.width,
              height: sizedBoxSize.height,
            )
          : CardWidget(
              onTap: () => expand(context),
              padding: const EdgeInsets.all(16.0),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DepartureArrivalWidget(
                    arrivalCity: widget.data.arrival,
                    departureCity: widget.data.departure,
                    departureDate: widget.data.departureTime,
                    isCargo: true,
                  ),
                  DividerWidget(),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 16.0,
                      alignment: WrapAlignment.spaceBetween,
                      children: <Widget>[
                        TwoLineInformationWidget(
                          iconColor: ModernTextTheme.captionIconColor,
                          icon: FontAwesomeIcons.cube,
                          title: 'Объем (см³)',
                          value:
                              (widget.data.properties.volume * 1000000.0).round().toString(),
                          unit: "см³",
                        ),
                        TwoLineInformationWidget(
                          iconColor: ModernTextTheme.captionIconColor,
                          icon: FontAwesomeIcons.weightHanging,
                          title: 'Вес (тонн)',
                          value: widget.data.properties.weight.toStringAsFixed(1),
                          unit: "т.",
                        ),
                        TwoLineInformationWidget(
                          iconColor: ModernTextTheme.captionIconColor,
                          icon: FontAwesomeIcons.boxOpen,
                          title: 'Тип кузова',
                          value: VehicleTypeUtils
                              .vehicleTypeNames[widget.data.information.vehicleType],
                          unit: "",
                        ),
                        TwoLineInformationWidget(
                          iconColor: ModernTextTheme.captionIconColor,
                          icon: FontAwesomeIcons.route,
                          title: 'Дистанция',
                          value: widget.data.route != null
                              ? (widget.data.route.distance / 1000.0)
                                  .toStringAsFixed(1)
                                  .toString()
                              : 'Неизвестно',
                          unit: widget.data.route != null? "км." : '',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Подробнее' +
                        ((widget.data.owner == AppData.username)
                            ? " (Ваш груз)"
                            : "")),
                    textColor: ModernTextTheme.secondaryColor,
                    disabledTextColor: ModernTextTheme.disabledColor,
                    onPressed:
                        (widget.addButtons) ? () => expand(context) : null,
                  ),
                ),
                IconButton(
                  icon: Icon(
                      (widget.data.starred)
                          ? FontAwesomeIcons.solidStar
                          : FontAwesomeIcons.star,
                      size: 20.0),
                  color: (widget.data.starred)
                      ? Colors.amber
                      : ModernTextTheme.secondaryColor,
                  iconSize: 20.0,
                  padding: const EdgeInsets.all(12.0),
                  onPressed: () => setState(() => widget.data.toggleStarred(context)),
                ),
              ],
            ),
    );
  }
}
