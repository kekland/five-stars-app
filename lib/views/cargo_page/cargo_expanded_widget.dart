import 'package:five_stars/Api/Api.dart';
import 'package:five_stars/controllers/main_page_controller.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/cargo_information_widget.dart';
import 'package:five_stars/design/dimensions_widget.dart';
import 'package:five_stars/design/map_route.dart';
import 'package:five_stars/design/properties_widget.dart';
import 'package:five_stars/design/transparent_route.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/cargo_page/cargo_edit_page.dart';
import 'package:five_stars/views/cargo_page/cargo_widget.dart';
import 'package:five_stars/views/profile_page/profile_page.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CargoExpandedWidget extends StatefulWidget {
  final Cargo data;
  final String heroPrefix;

  const CargoExpandedWidget({Key key, this.data, this.heroPrefix})
      : super(key: key);

  @override
  _CargoExpandedWidgetState createState() => _CargoExpandedWidgetState();
}

class _CargoExpandedWidgetState extends State<CargoExpandedWidget>
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
                uid: widget.data.owner, includeBackButton: true),
          );
        },
      ),
    );
  }

  void editCargo(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(TransparentRoute(
      builder: (_) {
        return CargoEditPage(
          data: widget.data,
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
          departureTime: widget.data.departureTime,
          route: widget.data.route,
        );
      },
    ));
  }

  void deleteCargo(BuildContext context) async {
    bool shouldDelete = (await showModernDialog(
          context: context,
          title: 'Вы уверены, что хотите удалить свой груз?',
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
        await CargoApi.deleteCargo(context: context, id: widget.data.id);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showInfoSnackbarMain(message: 'Груз успешно удалён');
      } catch (e) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        showErrorSnackbarMain(
            errorMessage: 'Произошла ошибка при удалении груза', exception: e);
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
          CargoWidget(
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
            PropertiesWidget(data: widget.data.properties, route: widget.data.route),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            DimensionsWidget(data: widget.data.dimensions),
          ),
          SizedBox(height: 16.0),
          buildInfoCardWidget(
            CargoInformationWidget(data: widget.data.information),
          ),
          SizedBox(height: 32.0),
          buildInfoCardWidget(
            TwoLineInformationWidgetExpanded(
              iconColor: ModernTextTheme.captionIconColor,
              icon: FontAwesomeIcons.userAlt,
              title: 'Профиль владельца',
              value: widget.data.owner,
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
          if (AppData.username == widget.data.owner) ...[
            buildInfoCardWidget(
              SingleLineInformationWidget(
                  icon: Icons.edit, label: 'Изменить', color: Colors.indigo),
              () => editCargo(context),
            ),
            SizedBox(height: 16.0),
            buildInfoCardWidget(
              SingleLineInformationWidget(
                  icon: Icons.delete, label: 'Удалить', color: Colors.red),
              () => deleteCargo(context),
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
