import 'package:five_stars/api/vehicle.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/map_route.dart';
import 'package:five_stars/design/transparent_route.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/views/cargo_page/cargo_widget.dart';
import 'package:five_stars/views/profile_page/profile_page.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:five_stars/views/vehicle_page/vehicle_alter_page.dart';
import 'package:five_stars/views/vehicle_page/vehicle_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VehicleExpandedWidget extends StatefulWidget {
  final Vehicle data;
  final String heroPrefix;

  const VehicleExpandedWidget({Key key, this.data, this.heroPrefix})
      : super(key: key);

  @override
  _VehicleExpandedWidgetState createState() => _VehicleExpandedWidgetState();
}

class _VehicleExpandedWidgetState extends State<VehicleExpandedWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    controller.addListener(() => setState(() {}));
    Future.delayed(Duration(milliseconds: 400), () {
      controller.forward(from: 0.0);
    });

    super.initState();
  }

  void openProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            body: ProfilePage(
                username: widget.data.ownerId, includeScaffold: true),
          );
        },
      ),
    );
  }

  void editVehicle(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(TransparentRoute(
      builder: (_) {
        return VehicleAlterPage(
          mainContext: context,
          mode: AlterMode.edit,
          defaultData: widget.data,
        );
      },
    ));
  }

  void openMap(BuildContext context) async {
    await checkForLocationPermission();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return MapRoutePage(
          arrival: widget.data.arrival,
          departure: widget.data.departure,
          route: widget.data.route,
        );
      },
    ));
  }

  void deleteVehicle(BuildContext context) async {
    bool shouldDelete = (await showModernDialog(
          context: context,
          title: 'Вы уверены, что хотите удалить свой транспорт?',
          text: 'Этот процесс необратим.',
          actions: [
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Отмена"),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              textColor: Colors.pink,
              child: Text("Удалить"),
            ),
          ],
        )) ??
        false;

    if (shouldDelete) {
      try {
        //API.delete()
        showLoadingDialog(context: context, color: Colors.pink);
        //await Future.delayed(Duration(seconds: 2));
        await VehicleApi.deleteVehicle(context: context, id: widget.data.id);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showInfoSnackbarMain(message: 'Транспорт успешно удалён');
      } catch (e) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showErrorSnackbarMain(
            errorMessage: 'Произошла ошибка при удалении транспорта',
            exception: e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 3.0,
          left: 18.0,
          right: 18.0,
          bottom: 36.0),
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          VehicleWidget(
            data: widget.data,
            heroPrefix: widget.heroPrefix,
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
                  icon: FontAwesomeIcons.dolly,
                  title: 'Место выгрузки',
                  value: widget.data.arrival.name,
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
                  value: VehicleTypeUtils
                      .vehicleTypeNames[widget.data.vehicleType],
                  unit: "",
                ),
                SizedBox(height: 16.0),
                TwoLineInformationWidgetExpanded(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.cube,
                  title: 'Макс. объём (м³)',
                  value: widget.data.volume.cubicMeter.round().toString(),
                  unit: "м³",
                ),
                SizedBox(height: 16.0),
                TwoLineInformationWidgetExpanded(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.weightHanging,
                  title: 'Макс. вес (тонн)',
                  value: widget.data.weight.ton.round().toString(),
                  unit: "т.",
                ),
                SizedBox(height: 16.0),
                TwoLineInformationWidgetExpanded(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.route,
                  title: 'Дистанция',
                  value: widget.data.route != null
                      ? (widget.data.route.distance / 1000.0)
                          .toStringAsFixed(1)
                          .toString()
                      : 'Неизвестно',
                  unit: widget.data.route != null ? "км." : '',
                ),
                SizedBox(height: 16.0),
                TwoLineInformationWidgetExpanded(
                  iconColor: ModernTextTheme.captionIconColor,
                  icon: FontAwesomeIcons.infoCircle,
                  title: 'Дополнительная информация',
                  value: widget.data.description,
                  unit: "",
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            TwoLineInformationWidgetExpanded(
              iconColor: Colors.green,
              icon: FontAwesomeIcons.tenge,
              title: 'Цена',
              value: 'Договорная',
              unit: '',
            ),
          ),
          SizedBox(height: 32.0),
          buildInfoCardWidget(
            TwoLineInformationWidgetExpanded(
              iconColor: ModernTextTheme.captionIconColor,
              icon: FontAwesomeIcons.userAlt,
              title: 'Профиль владельца',
              value: widget.data.ownerId,
              unit: "",
            ),
            () => openProfile(context),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            SingleLineInformationWidget(
                icon: FontAwesomeIcons.globeAsia, label: 'Посмотреть на карте'),
            () => openMap(context),
          ),
          SizedBox(height: 16.0),
          if (AppData.username == widget.data.ownerId) ...[
            buildInfoCardWidget(
              SingleLineInformationWidget(
                  icon: Icons.edit, label: 'Изменить', color: Colors.indigo),
              () => editVehicle(context),
            ),
            SizedBox(height: 16.0),
            buildInfoCardWidget(
              SingleLineInformationWidget(
                  icon: Icons.delete, label: 'Удалить', color: Colors.red),
              () => deleteVehicle(context),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildInfoCardWidget(Widget child,
      [VoidCallback onTap = null,
      EdgeInsets padding = const EdgeInsets.all(16.0)]) {
    return Transform.translate(
      offset: Offset(0.0, 25.0 * (1.0 - animation.value)),
      child: Opacity(
        opacity: animation.value.clamp(0.0, 1.0),
        child: CardWidget(
          onTap: onTap,
          padding: padding,
          body: child,
        ),
      ),
    );
  }
}
