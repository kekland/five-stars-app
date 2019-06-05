import 'package:five_stars/controllers/profile_page_controller.dart';
import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/profile_page/profile_view.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  const ProfilePage({Key key, this.username}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends Presenter<ProfilePage, ProfilePageController> {
  @override
  void initController() {
    controller = ProfilePageController(presenter: this);
  }

  @override
  void initState() {
    super.initState();
    controller.load(
        context: context,
        username: widget.username);
  }

  Widget buildChild() {
    if (controller.isLoading) {
      return Center(
        child: CircularProgressRevealWidget(color: Colors.indigo),
      );
    } else if (controller.data == null) {
      return Center(
        child: CircularProgressRevealWidget(color: Colors.indigo),
      );
    } else {
      return ProfileViewWidget(
        profile: controller.data,
      );
    }
  }

  @override
  Widget present(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          AppBarWidget(
            title: Text('Личный кабинет'),
          ),
          Expanded(
            child: LiquidPullToRefresh(
              color: Colors.indigo,
              springAnimationDurationInMilliseconds: 500,
              child: buildSingularDataPage(
                context: context,
                accentColor: Colors.indigo,
                data: controller.data,
                isLoading: controller.isLoading,
                builder: (context, profile) => ProfileViewWidget.buildAsListView(context: context, profile: profile),
              ),
              onRefresh: () async => await controller.load(context: context, username: widget.username),
            ),
          ),
        ],
      ),
    );
  }
}
