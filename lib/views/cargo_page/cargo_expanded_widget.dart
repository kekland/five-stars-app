import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/cargo_page/cargo_widget.dart';
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

  void requestCallAPI(BuildContext context) async {
    //TODO
    Navigator.of(context).pop();
    showLoadingDialog(context: context, color: Colors.pink);
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pop();
    showModernDialog(
      context: context,
      title: 'Запрос отправлен.',
      text: 'Наш оператор перезвонит вам в ближайшее время',
      actions: <Widget>[
        FlatButton(
          child: Text('Хорошо'),
          onPressed: () => Navigator.of(context).pop(),
          textColor: Colors.pink,
        ),
      ],
    );
  }

  void requestCall(BuildContext context) {
    showModernDialog(
      context: context,
      title: 'Запросить дополнительную информацию о грузе?',
      text: 'Наш оператор перезвонит вам в ближайшее время',
      actions: <Widget>[
        FlatButton(
          child: Text('Отмена'),
          onPressed: () => Navigator.of(context).pop(),
          textColor: Colors.pink,
        ),
        FlatButton(
          child: Text('Запросить'),
          onPressed: () => requestCallAPI(context),
          textColor: Colors.pink,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.0, left: 18.0, right: 18.0, bottom: 36.0),
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          CargoWidget(
            data: widget.data,
            addButtons: false,
          ),
          SizedBox(height: 32.0),
          buildInfoCardWidget(
            TwoLineInformationWidgetExpanded(
              iconColor: ModernTextTheme.captionIconColor,
              icon: FontAwesomeIcons.tag,
              title: 'Идентификатор',
              value: widget.data.id.toString(),
              unit: "",
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TwoLineInformationWidgetExpanded(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.truckLoading,
                  title: 'Место погрузки',
                  value: widget.data.departure.name,
                  unit: "",
                ),
                SizedBox(height: 16.0),
                TwoLineInformationWidgetExpanded(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.truckLoading,
                  showIcon: false,
                  title: 'Дата погрузки',
                  value: dateTimeToString(widget.data.departureTime),
                  unit: "",
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TwoLineInformationWidgetExpanded(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.dolly,
                  title: 'Место выгрузки',
                  value: widget.data.arrival.name,
                  unit: "",
                ),
                SizedBox(height: 16.0),
                TwoLineInformationWidgetExpanded(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.truckLoading,
                  showIcon: false,
                  title: 'Дата выгрузки',
                  value: dateTimeToString(widget.data.arrivalTime),
                  unit: "",
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TwoLineInformationWidgetExpanded(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.truckMoving,
                  title: 'Тип кузова',
                  value: VehicleTypeUtils.vehicleTypeNames[widget.data.vehicleType],
                  unit: "",
                ),
                SizedBox(height: 16.0),
                TwoLineInformationWidgetExpanded(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.cube,
                  title: 'Объём (м³)',
                  value: widget.data.volume.cubicMeter.round().toString(),
                  unit: "м³",
                ),
                SizedBox(height: 16.0),
                TwoLineInformationWidgetExpanded(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.weightHanging,
                  title: 'Вес (тонн)',
                  value: widget.data.weight.ton.round().toString(),
                  unit: "т.",
                ),
                /*SizedBox(height: 16.0),
                TwoLineInformationWidgetExpanded(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.boxOpen,
                  title: 'Тип груза',
                  value: widget.data.imageKeyword,
                  unit: "",
                ),*/
              ],
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            TwoLineInformationWidgetExpanded(
              iconColor: Colors.green,
              icon: FontAwesomeIcons.tenge,
              title: 'Цена',
              value: widget.data.price.truncate().toString(),
              unit: "тг.",
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            SizedBox(
              width: double.infinity,
              child: FlatButton.icon(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                icon: Icon(FontAwesomeIcons.infoCircle, size: 20.0),
                label: Text('Запросить дополнительную информацию'),
                onPressed: () => requestCall(context),
                textColor: ModernTextTheme.secondaryColor,
                padding: const EdgeInsets.all(18.0),
              ),
            ),
            EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget buildInfoCardWidget(Widget child, [EdgeInsets padding = const EdgeInsets.all(16.0)]) {
    return Transform.translate(
      offset: Offset(0.0, 15.0 * (1.0 - animation.value)),
      child: Opacity(
        opacity: animation.value.clamp(0.0, 1.0),
        child: CardWidget(
          padding: padding,
          body: child,
        ),
      ),
    );
  }
}
