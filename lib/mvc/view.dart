import 'package:flutter/material.dart';

class Controller<T extends StatefulWidget> {
  Presenter presenter;

  Controller({this.presenter});

  void dispose() {
    presenter = null;
  }

  void refresh() {
    presenter.refresh();
  }

  void update(Function func) {
    presenter.update(func);
  }
}

abstract class Presenter<T extends StatefulWidget, I extends Controller<T>> extends State<T> {
  I controller;

  void onInit() {}
  void onDispose() {}
  void initController();

  Widget present(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return present(context);
  }

  @override
  void initState() {
    super.initState();
    initController();
    onInit();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    controller = null;
    onDispose();
  }
  
  void refresh() {
    setState(() {});
  }

  void update(Function func) {
    setState(func);
  }
}
