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
                action: IconButton(icon: Icon(Icons.add), color: Colors.pink, onPressed: () => addCargo(context)),
              ),
              Expanded(
                child: FuturePage(
                  accentColor: Colors.pink,
                  onSuccess: () => (controller.data.length > 0)
                      ? ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: CargoWidget(data: controller.data[index]),
                            );
                          },
                        )
                      : EmptyWidget(
                          accentColor: Colors.pink,
                          onRefresh: () => controller.load(context),
                        ),
                  state: controller.getFutureState(),
                  error: controller.error,
                  onRefresh: () => controller.load(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
