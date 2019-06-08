import 'package:five_stars/controllers/profile_page_controller.dart';
import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:five_stars/design/transparent_route.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/cargo_model.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:five_stars/utils/app_data.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/profile_page/profile_view.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final bool includeBackButton;
  const ProfilePage({Key key, this.username, this.includeBackButton = false})
      : super(key: key);
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
    controller.load(context: context, username: widget.username);
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
      return ProfileViewWidget.buildAsListView(
        profile: controller.data,
      );
    }
  }

  void editProfile(BuildContext context) {
    Navigator.of(context).push(
      TransparentRoute(
        builder: (context) {
          //return CargoExpandedWidget(data: widget.data);
        },
      ),
    );
  }

  @override
  Widget present(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          AppBarWidget(
            title: Text('Профиль ${widget.username}'),
            includeBackButton: widget.includeBackButton,
            accentColor: Colors.indigo,
            action: (widget.username == AppData.username)
                ? IconButton(
                    color: Colors.indigo,
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  )
                : null,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                if (controller.firstLoad && controller.data == null)
                  Center(
                    child: CircularProgressRevealWidget(color: Colors.indigo),
                  ),
                LiquidPullToRefresh(
                  color: Colors.indigo,
                  springAnimationDurationInMilliseconds: 500,
                  child: buildSingularDataPage(
                    context: context,
                    accentColor: Colors.indigo,
                    data: controller.data,
                    isLoading: controller.isLoading,
                    builder: (context, profile) =>
                        ProfileViewWidget.buildAsListView(
                          profile: controller.data,
                        ),
                  ),
                  onRefresh: () async => await controller.load(
                      context: context, username: widget.username),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
