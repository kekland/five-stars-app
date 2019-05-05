import 'package:five_stars/controllers/cargo_page_controller.dart';
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
    if(controller.loading) {
      return Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: controller.data.length,
      itemBuilder: (context, index) {
        return CargoWidget(data: controller.data[index]);
      },
    );
  }
  
}