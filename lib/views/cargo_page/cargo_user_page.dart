import 'package:five_stars/api/user.dart';
import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'dart:math' as math;
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/cargo_page/cargo_list.dart';
import 'package:flutter/material.dart';

class CargoUserPage extends StatefulWidget {
  final String username;
  final String fabHeroSuffix;
  final bool favorites;

  const CargoUserPage({Key key, this.username, this.favorites = false, this.fabHeroSuffix}) : super(key: key);
  @override
  _CargoUserPageState createState() => _CargoUserPageState();
}

class _CargoUserPageState extends State<CargoUserPage> {
  bool isLoading = true;
  List<Cargo> data;

  load({BuildContext context}) async {
    data = null;
    isLoading = true;
    setState(() => {});
    try {
      data = await UserApi.getUserCargo(
          context: context, username: widget.username, favorites: widget.favorites);
    } catch (e) {
      data = null;
      showErrorSnackbar(
          context: context,
          errorMessage: "Произошла ошибка при получении профиля",
          exception: e);
    }

    isLoading = false;
    setState(() => {});
  }

  @override
  void initState() {
    load(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (isLoading)
          Center(
            child: CircularProgressRevealWidget(color: Colors.red),
          ),
        buildSingularDataPage(
          context: context,
          accentColor: Colors.red,
          data: data,
          isLoading: isLoading,
          builder: (context, data) => CargoList(cargo: data),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Visibility(
              visible: (!isLoading),
              child: FloatingActionButton(
                heroTag: 'cargo_user_page_fab_${math.Random().nextInt(325912321)}',
                onPressed: () async => await load(context: context),
                child: Icon(Icons.refresh),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
