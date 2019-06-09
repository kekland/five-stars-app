import 'package:five_stars/controllers/vehicle_alter_controller.dart';
import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/divider_widget.dart';
import 'package:five_stars/design/select_city_widget.dart';
import 'package:five_stars/design/select_time_widget.dart';
import 'package:five_stars/design/select_vehicle_type.dart';
import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VehicleAlterPage extends StatefulWidget {
  final AlterMode mode;
  final BuildContext mainContext;

  final Vehicle defaultData;

  const VehicleAlterPage(
      {Key key, this.mainContext, this.mode = AlterMode.add, this.defaultData})
      : super(key: key);
  @override
  _VehicleAlterPageState createState() => _VehicleAlterPageState();
}

class _VehicleAlterPageState
    extends Presenter<VehicleAlterPage, VehicleAlterController> {
  Widget buildCitySelectionWidget(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(8.0),
      body: Column(
        children: [
          SelectCityWidget(
            icon: FontAwesomeIcons.truckLoading,
            subtitle: 'Город погрузки',
            selectedCity: controller.selectedDepartureCity,
            onSelected: (city) =>
                setState(() => controller.selectedDepartureCity = city),
          ),
          SizedBox(height: 16.0),
          SelectCityWidget(
            icon: FontAwesomeIcons.dolly,
            subtitle: 'Город выгрузки',
            selectedCity: controller.selectedArrivalCity,
            onSelected: (city) =>
                setState(() => controller.selectedArrivalCity = city),
          ),
        ],
      ),
    );
  }

  Widget buildInfoWidget(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(16.0),
      body: Column(
        children: [
          ModernTextField(
            icon: FontAwesomeIcons.weightHanging,
            hintText: "Макс. вес",
            controller: controller.weightEditingController,
            error: controller.weight.error,
            onSubmitted: controller.weight.validate,
            onChanged: controller.weight.setValue,
            keyboardType: TextInputType.number,
            suffixText: "кг.",
          ),
          SizedBox(height: 16.0),
          ModernTextField(
            icon: FontAwesomeIcons.box,
            hintText: "Макс. объём",
            controller: controller.volumeEditingController,
            error: controller.volume.error,
            onSubmitted: controller.volume.validate,
            onChanged: controller.volume.setValue,
            keyboardType: TextInputType.number,
            suffixText: "м3.",
          ),
        ],
      ),
    );
  }

  Widget buildVehicleTypeWidget(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(8.0),
      body: Column(children: [
        SelectVehicleType(
          selectedVehicleType: controller.selectedVehicleType,
          onSelect: (type) =>
              setState(() => controller.selectedVehicleType = type),
        ),
      ]),
    );
  }

  Widget buildDescriptionWidget(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(16.0),
      body: Column(
        children: [
          ModernTextField(
            icon: FontAwesomeIcons.infoCircle,
            hintText: "Доп. информация",
            lines: 1,
            controller: controller.infoEditingController,
            error: controller.info.error,
            onSubmitted: controller.info.validate,
            onChanged: controller.info.setValue,
          ),
        ],
      ),
    );
  }

  void alterVehicle(BuildContext context) {
    if (widget.mode == AlterMode.add) {
      controller.addVehicle(widget.mainContext);
    } else {
      controller.editVehicle(context);
    }
  }

  Widget buildAddWidget(BuildContext context) {
    return CardWidget(
      padding: EdgeInsets.zero,
      body: SizedBox(
        width: double.infinity,
        height: 56.0,
        child: FlatButton(
          child: Text(
            (widget.mode == AlterMode.add) ? 'Добавить' : 'Изменить',
            style: ModernTextTheme.primaryAccented.copyWith(
              color: (controller.isValid())
                  ? Colors.purple
                  : ModernTextTheme.captionColor,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          onPressed: (controller.isValid()) ? () => alterVehicle(context) : null,
        ),
      ),
    );
  }

  @override
  Widget present(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 3.0,
              left: 18.0,
              right: 18.0,
              bottom: 36.0),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CardWidget(
                padding: const EdgeInsets.all(24.0),
                body: Text(
                    (widget.mode == AlterMode.add)
                        ? 'Добавить транспорт'
                        : 'Изменить транспорт',
                    style: ModernTextTheme.boldTitle),
              ),
              SizedBox(height: 16.0),
              buildCitySelectionWidget(context),
              SizedBox(height: 16.0),
              buildInfoWidget(context),
              SizedBox(height: 16.0),
              buildVehicleTypeWidget(context),
              SizedBox(height: 16.0),
              buildDescriptionWidget(context),
              SizedBox(height: 16.0),
              buildAddWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initController() {
    controller = new VehicleAlterController(presenter: this);

    if (widget.mode == AlterMode.edit) {
      controller.setFields(widget.defaultData);
    }
  }
}
