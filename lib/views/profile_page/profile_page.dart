import 'package:five_stars/controllers/profile_page_controller.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends Presenter<ProfilePage, ProfilePageController> {
  @override
  void initController() {
    controller = ProfilePageController(presenter: this);
  }

  @override
  Widget present(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}