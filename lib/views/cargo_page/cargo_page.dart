import 'package:five_stars/design/shadows/shadows.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/views/cargo_page/cargo_widget.dart';
import 'package:flutter/material.dart';

class CargoPage extends StatefulWidget {
  final List<Cargo> cargo;
  const CargoPage({Key key, this.cargo}) : super(key: key);

  @override
  _CargoPageState createState() => _CargoPageState();
}

class _CargoPageState extends State<CargoPage> {
  List<Cargo> cargo;
  @override
  void initState() {
    cargo = List.from(widget.cargo);
    cargo.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    super.initState();
  }

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
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: CargoWidget(
                data: cargo[index],
                context: context,
                onCargoDeleted: () => setState(() => cargo.removeAt(index)),
                onCargoEdited: (data) => setState(() => cargo[index] = data),
              ),
            ),
      ),
    );
  }
}
