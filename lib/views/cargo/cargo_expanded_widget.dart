import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/cargo/cargo_widget.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CargoExpandedWidget extends StatefulWidget {
  final Cargo data;

  const CargoExpandedWidget({Key key, this.data}) : super(key: key);

  @override
  _CargoExpandedWidgetState createState() => _CargoExpandedWidgetState();
}

class _CargoExpandedWidgetState extends State<CargoExpandedWidget> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    controller.addListener(() => setState(() {}));
    Future.delayed(Duration(milliseconds: 400), () {
      controller.forward(from: 0.0);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.0, left: 36.0, right: 36.0, bottom: 36.0),
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          CargoWidget(
            data: widget.data,
            addButtons: false,
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            TwoLineInformationWidget(
              iconColor: ModernTextTheme.captionIconColor,
              icon: FontAwesomeIcons.pallet,
              title: 'Идентификатор',
              value: widget.data.id,
              unit: "",
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            TwoLineInformationWidget(
              iconColor: ModernTextTheme.captionIconColor,
              icon: FontAwesomeIcons.truckLoading,
              title: 'Дата погрузки',
              value: dateTimeToString(widget.data.departureDate),
              unit: "",
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            TwoLineInformationWidget(
              iconColor: ModernTextTheme.captionIconColor,
              icon: FontAwesomeIcons.dolly,
              title: 'Дата выгрузки',
              value: dateTimeToString(widget.data.arrivalDate),
              unit: "",
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            TwoLineInformationWidget(
              iconColor: ModernTextTheme.captionIconColor,
              icon: FontAwesomeIcons.city,
              title: 'Место погрузки',
              value: widget.data.departureCity.name,
              unit: "",
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            TwoLineInformationWidget(
              iconColor: ModernTextTheme.captionIconColor,
              icon: FontAwesomeIcons.city,
              title: 'Место выгрузки',
              value: widget.data.arrivalCity.name,
              unit: "",
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            TwoLineInformationWidget(
              iconColor: ModernTextTheme.captionIconColor,
              icon: FontAwesomeIcons.truckMoving,
              title: 'Тип кузова',
              value: "Тент",
              unit: "",
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            TwoLineInformationWidget(
              iconColor: ModernTextTheme.captionIconColor,
              icon: FontAwesomeIcons.cube,
              title: 'Объём (м³)',
              value: widget.data.volume.cubicMeter.round().toString(),
              unit: "м³",
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            TwoLineInformationWidget(
              iconColor: ModernTextTheme.captionIconColor,
              icon: FontAwesomeIcons.weightHanging,
              title: 'Вес (тонн)',
              value: widget.data.weight.ton.round().toString(),
              unit: "т.",
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            TwoLineInformationWidget(
              iconColor: Colors.green,
              icon: FontAwesomeIcons.dollarSign,
              title: 'Цена',
              value: widget.data.shipmentCost.truncate().toString(),
              unit: "тг.",
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoCardWidget(Widget child) {
    return Transform.translate(
      offset: Offset(0.0, 15.0 * (1.0 - animation.value)),
      child: Opacity(
        opacity: animation.value.clamp(0.0, 1.0),
        child: CardWidget(
          padding: const EdgeInsets.all(16.0),
          body: child,
        ),
      ),
    );
  }
}
