import 'package:five_stars/controllers/vehicle_page_controller.dart';
import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/views/vehicle_page/vehicle_filter_widget.dart';
import 'package:five_stars/views/vehicle_page/vehicle_widget.dart';
import 'package:flutter/material.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({Key key}) : super(key: key);

  @override
  VehiclePageState createState() => VehiclePageState();
}

class VehiclePageState extends Presenter<VehiclePage, VehiclePageController> {
  @override
  void initController() {
    controller = VehiclePageController(presenter: this);
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
              ),
              Expanded(
                child: FuturePage(
                  onSuccess: () => ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        physics: BouncingScrollPhysics(),
                        itemCount: controller.data.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: VehicleFilterWidget(),
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: VehicleWidget(data: controller.data[index - 1]),
                          );
                        },
                      ),
                  state: controller.getFutureState(),
                  error: controller.error,
                  onRefresh: controller.load,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
