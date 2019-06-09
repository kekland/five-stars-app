import 'package:five_stars/api/cargo.dart';
import 'package:five_stars/api/user.dart';
import 'package:five_stars/api/vehicle.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/models/vehicle_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/profile_page/profile_page.dart';
import 'package:flutter/material.dart';

class ProfilePageController extends Controller<ProfilePage> {
  bool isLoading;
  bool firstLoad = true;
  User data;

  bool isCargoLoading;
  List<Cargo> cargo;

  bool isVehicleLoading;
  List<Vehicle> vehicle;

  bool isCargoSelected = true;

  ProfilePageController(
      {Presenter<ProfilePage, ProfilePageController> presenter}) {
    this.presenter = presenter;
  }

  Future loadCargo({BuildContext context}) async {
    cargo = null;
    isCargoLoading = true;
    
    refresh();
    try {
      cargo = await CargoApi.getCargoBatched(data.cargo);
    } catch (e) {
      showErrorSnackbar(
        context: context,
        errorMessage: "Произошла ошибка при получении грузов у пользователя",
        exception: e,
      );
    }
    isCargoLoading = false;
    refresh();
  }
  
  Future loadVehicle({BuildContext context}) async {
    vehicle = null;
    isVehicleLoading = true;
    
    refresh();
    try {
      vehicle = await VehicleApi.getVehicleBatched(data.vehicles);
    } catch (e) {
      showErrorSnackbar(
        context: context,
        errorMessage: "Произошла ошибка при получении транспорта у пользователя",
        exception: e,
      );
    }
    isVehicleLoading = false;
    refresh();
  }

  Future load({BuildContext context, String username}) async {
    data = null;
    vehicle = null;
    isLoading = true;
    isVehicleLoading = true;
    cargo = null;
    isCargoLoading = true;
    refresh();
    try {
      data = await UserApi.getProfile(username);
      loadCargo(context: context);
      loadVehicle(context: context);
    } catch (e) {
      data = null;
      showErrorSnackbar(
          context: context,
          errorMessage: "Произошла ошибка при получении профиля",
          exception: e);
    }

    isLoading = false;
    firstLoad = false;
    refresh();
  }

  void setIsCargoSelected(bool value) {
    isCargoSelected = value;
    refresh();
  }
}
