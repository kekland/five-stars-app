import 'package:five_stars/api/user.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'dart:math' as math;
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/vehicle_page/vehicle_list.dart';
import 'package:flutter/material.dart';

class VehicleUserPage extends StatefulWidget {
  final String username;
  final String fabHeroSuffix;
  final bool favorites;

  const VehicleUserPage(
      {Key key, this.username, this.favorites = false, this.fabHeroSuffix})
      : super(key: key);
  @override
  _VehicleUserPageState createState() => _VehicleUserPageState();
}

class _VehicleUserPageState extends State<VehicleUserPage> {
  bool showOnlyPublishing = false;
  bool isLoading = true;
  List<Vehicle> data;

  load({BuildContext context}) async {
    data = null;
    isLoading = true;
    setState(() {});
    try {
      data = await UserApi.getUserVehicles(
          context: context,
          username: widget.username,
          favorites: widget.favorites);
    } catch (e) {
      data = null;
      showErrorSnackbar(
          context: context,
          errorMessage: "Произошла ошибка при получении профиля",
          exception: e);
    }

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    load(context: context);
    super.initState();
  }

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CardWidget(
          padding: EdgeInsets.all(8.0),
          body: Container(
            child: CheckboxListTile(
              value: showOnlyPublishing,
              onChanged: (v) {
                setState(() => showOnlyPublishing = v);
                load(context: context);
              },
              title: Text('Показать только публикующиеся'),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              if (isLoading)
                Center(
                  child: CircularProgressRevealWidget(color: ModernColorTheme.main),
                ),
              buildSingularDataPage(
                context: context,
                accentColor: ModernColorTheme.main,
                data: data == null
                    ? null
                    : data
                        .where((v) => (showOnlyPublishing)
                            ? now.difference(v.createdAt).inDays < 7
                            : true)
                        .toList(),
                isLoading: isLoading,
                builder: (context, data) => VehicleList(
                  vehicle: data,
                  vehicleHeroPrefix: 'vehicle_user_page',
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Visibility(
                    visible: (!isLoading),
                    child: FloatingActionButton(
                      heroTag:
                          'vehicle_user_page_fab_${math.Random().nextInt(325912321)}',
                      onPressed: () async => await load(context: context),
                      child: Icon(Icons.refresh),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
