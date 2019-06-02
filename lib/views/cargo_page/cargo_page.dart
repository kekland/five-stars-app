import 'package:five_stars/controllers/cargo_page_controller.dart';
import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:five_stars/design/empty_widget.dart';
import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/design/page_header_widget.dart';
import 'package:five_stars/design/transparent_route.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/views/cargo_page/cargo_add_sheet.dart';
import 'package:five_stars/views/cargo_page/cargo_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class CargoPage extends StatefulWidget {
  const CargoPage({Key key}) : super(key: key);
  @override
  _CargoPageState createState() => _CargoPageState();
}

class _CargoPageState extends Presenter<CargoPage, CargoPageController> {
  @override
  void initController() {
    controller = CargoPageController(presenter: this);
  }

  @override
  void initState() {
    super.initState();
    controller.load(context);
  }

  void addCargo(BuildContext context) {
    Navigator.of(context).push(TransparentRoute(
      builder: (_) {
        return CargoAddPage(mainContext: context);
      },
    ));
  }

  @override
  Widget present(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              AppBarWidget(
                title: Text('Свободный груз'),
                action: IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.pink,
                    onPressed: () => addCargo(context)),
              ),
              Expanded(
                child: LiquidPullToRefresh(
                  color: Colors.pink,
                  springAnimationDurationInMilliseconds: 500,
                  child: buildDataPage<Cargo>(
                    accentColor: Colors.pink,
                    builder: (context, item) => CargoWidget(data: item),
                    data: controller.data,
                    error: controller.error,
                  ),
                  onRefresh: () async => await controller.load(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
