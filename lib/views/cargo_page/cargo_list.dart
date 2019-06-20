import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/views/cargo_page/cargo_widget.dart';
import 'package:flutter/material.dart';

class CargoList extends StatefulWidget {
  final List<Cargo> cargo;
  final String cargoHeroPrefix;

  static int cargoListIndex = 0;

  const CargoList({Key key, this.cargo, this.cargoHeroPrefix}) : super(key: key);

  @override
  _CargoListState createState() => _CargoListState();
}

class _CargoListState extends State<CargoList> {
  List<Cargo> cargo;
  int cargoListIndex;
  @override
  void initState() {
    cargo = List.from(widget.cargo);
    cargo.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    cargoListIndex = CargoList.cargoListIndex;
    CargoList.cargoListIndex++;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cargo.length,
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: CargoWidget(
              key: ValueKey(cargo[index].id),
              data: cargo[index],
              context: context,
              heroPrefix: '${widget.cargoHeroPrefix}_$cargoListIndex',
              onCargoDeleted: () => setState(() => cargo.removeAt(index)),
              onCargoEdited: (data) => setState(() => cargo[index] = data),
            ),
          ),
    );
  }
}
