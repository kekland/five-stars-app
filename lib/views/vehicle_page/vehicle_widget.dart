import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/divider_widget.dart';
import 'package:five_stars/design/transparent_route.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/arrival_destination_widget.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:five_stars/views/vehicle_page/vehicle_expanded_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VehicleWidget extends StatefulWidget {
  final Vehicle data;
  final String heroPrefix;
  final bool addButtons;

  const VehicleWidget(
      {Key key, this.data, this.addButtons = true, this.heroPrefix = ""})
      : super(key: key);

  @override
  _VehicleWidgetState createState() => _VehicleWidgetState();
}

class _VehicleWidgetState extends State<VehicleWidget> {
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
          return VehicleExpandedWidget(
            data: widget.data,
            heroPrefix: widget.heroPrefix,
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
      tag: "${widget.heroPrefix}_vehicle_${this.widget.data.id}",
      flightShuttleBuilder:
          (context, animation, direction, context1, context2) {
        return VehicleWidget(data: widget.data, addButtons: true);
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
                    isCargo: false,
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
                          title: 'Объем (м³)',
                          value:
                              widget.data.volume.cubicMeter.round().toString(),
                          unit: "м³",
                        ),
                        TwoLineInformationWidget(
                          iconColor: ModernTextTheme.captionIconColor,
                          icon: FontAwesomeIcons.weightHanging,
                          title: 'Вес (тонн)',
                          value: widget.data.weight.ton.toStringAsFixed(1),
                          unit: "т.",
                        ),
                        TwoLineInformationWidget(
                          iconColor: ModernTextTheme.captionIconColor,
                          icon: FontAwesomeIcons.boxOpen,
                          title: 'Тип кузова',
                          value: VehicleTypeUtils
                              .vehicleTypeNames[widget.data.vehicleType],
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
                        ((widget.data.ownerId == AppData.username)
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
                  onPressed: () => setState(() => widget.data.toggleStarred()),
                ),
              ],
            ),
    );
  }
}
