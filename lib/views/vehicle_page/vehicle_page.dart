import 'package:five_stars/controllers/vehicle_page_controller.dart';
import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/design/transparent_route.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/vehicle_page/vehicle_widget.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({Key key}) : super(key: key);
  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends Presenter<VehiclePage, VehiclePageController> {
  @override
  void initController() {
    controller = VehiclePageController(presenter: this);
  }

  @override
  void initState() {
    super.initState();
    controller.load(context);
  }

  void addVehicle(BuildContext context) {
    Navigator.of(context).push(TransparentRoute(
      builder: (_) {
        //return CargoAlterPage(mainContext: context, mode: AlterMode.add);
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
                title: Text('Свободный транспорт'),
                action: IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.purple,
                    onPressed: () => addVehicle(context)),
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    if (controller.firstLoad && controller.data == null)
                      Center(
                        child: CircularProgressRevealWidget(color: Colors.purple),
                      ),
                    LiquidPullToRefresh(
                      color: Colors.purple,
                      springAnimationDurationInMilliseconds: 500,
                      child: buildDataPage<Vehicle>(
                        accentColor: Colors.purple,
                        builder: (context, item) => VehicleWidget(data: item),
                        data: controller.data,
                        error: controller.error,
                      ),
                      onRefresh: () async => await controller.load(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
