import 'package:five_stars/api/api.dart';
import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/city.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/utils/vehicle_type.dart';
import 'package:five_stars/utils/volume.dart';
import 'package:five_stars/utils/weight.dart';
import 'package:five_stars/views/cargo_page/cargo_page.dart';
import 'package:flutter/material.dart';

class CargoPageController extends Controller<CargoPage> {
  CargoPageController({Presenter<CargoPage, CargoPageController> presenter}) {
    this.presenter = presenter;
    data = null;
  }

  List<Cargo> data;
  bool loading = false;
  String error;
  bool firstLoad = true;

  Future load(BuildContext context) async {
    loading = true;
    error = null;
    presenter.refresh();
    try {
      //await Future.delayed(Duration(seconds: 5));
      data = await CargoApi.getCargo();
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
