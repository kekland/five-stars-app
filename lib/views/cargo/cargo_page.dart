import 'package:five_stars/controllers/cargo_page_controller.dart';
import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/design/page_header_widget.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/views/cargo/cargo_widget.dart';
import 'package:flutter/material.dart';

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
  Widget present(BuildContext context) {
    return SafeArea(
      child: FuturePage(
        onSuccess: () => ListView.builder(
              padding: const EdgeInsets.all(16.0),
              physics: BouncingScrollPhysics(),
              itemCount: controller.data.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: PageHeaderWidget(title: 'Свободный груз'),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CargoWidget(data: controller.data[index - 1]),
                );
              },
            ),
        state: controller.getFutureState(),
        error: controller.error,
        onRefresh: controller.load,
      ),
    );
  }
}
