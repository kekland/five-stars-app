import 'package:five_stars/design/shadows/shadows.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/views/cargo_page/cargo_widget.dart';
import 'package:flutter/material.dart';

class CargoPage extends StatelessWidget {
  final List<Cargo> cargo;
  const CargoPage({Key key, this.cargo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Найденный груз', style: TextStyle(color: Colors.black)),
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),  
      ),
      body: ListView.builder(
        itemCount: cargo.length,
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) => CargoWidget(data: cargo[index]),
      ),
    );
  }
}