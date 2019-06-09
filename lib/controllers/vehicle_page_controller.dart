import 'package:five_stars/api/api.dart';
import 'package:five_stars/api/vehicle.dart';
import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/vehicle_page/vehicle_page.dart';
import 'package:flutter/material.dart';

class VehiclePageController extends Controller<VehiclePage> {
  VehiclePageController({Presenter<VehiclePage, VehiclePageController> presenter}) {
    this.presenter = presenter;
    data = null;
  }

  List<Vehicle> data;
  bool loading = false;
  String error;
  bool firstLoad = true;

  Future load(BuildContext context) async {
    loading = true;
    error = null;
    presenter.refresh();
    try {
      //await Future.delayed(Duration(seconds: 5));
      data = await VehicleApi.getVehicles();
    } catch (e) {
      error = e.toString();
      await Future.delayed(Duration.zero, () {
        showErrorSnackbar(context: context, errorMessage: 'Что-то пошло не так', exception: e, showDialog: true);
      });
    }
    loading = false;
    firstLoad = false;
    presenter.refresh();
  }

  FutureState getFutureState() {
    if (loading) {
      return FutureState.Loading;
    } else {
      if (error != "") {
        return FutureState.Error;
      } else {
        return FutureState.Success;
      }
    }
  }
}
