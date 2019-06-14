import 'package:five_stars/api/api.dart';
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
import 'package:five_stars/views/cargo_page/cargo_widget.dart';
import 'package:five_stars/views/profile_page/profile_data.dart';
import 'package:five_stars/views/profile_page/profile_edit.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:five_stars/views/vehicle_page/vehicle_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  final bool includeBackButton;
  const ProfilePage({Key key, this.uid, this.includeBackButton = false})
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
    controller.load(context: context, uid: widget.uid);
  }

  void editProfile(BuildContext context) {
    Navigator.of(context).push(
      TransparentRoute(
        builder: (context) {
          return ProfileEditPage(data: controller.data);
        },
      ),
    );
  }

  Widget buildCard(
      {Widget child,
      VoidCallback onTap,
      EdgeInsets padding = const EdgeInsets.all(16.0)}) {
    return CardWidget(
      actions: [],
      body: child,
      padding: padding,
      onTap: onTap,
    );
  }

  ListView buildProfile({User profile}) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        buildCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TwoLineInformationWidgetExpanded(
                title: "Имя пользователя",
                value: profile.username,
                icon: FontAwesomeIcons.userAlt,
                unit: "",
                iconColor: ModernTextTheme.captionIconColor,
              ),
              SizedBox(height: 24.0),
              TwoLineInformationWidgetExpanded(
                title: "Почта",
                value: profile.email,
                icon: FontAwesomeIcons.solidEnvelope,
                unit: "",
                iconColor: ModernTextTheme.captionIconColor,
                onTap: () => launch(
                    'mailto:${profile.email}?body=Здравствуйте,%20${profile.name}.'),
              ),
              SizedBox(height: 24.0),
              TwoLineInformationWidgetExpanded(
                title: "Имя",
                value: "${profile.name}",
                icon: FontAwesomeIcons.userAlt,
                unit: "",
                iconColor: ModernTextTheme.captionIconColor,
              ),
              SizedBox(height: 24.0),
              TwoLineInformationWidgetExpanded(
                title: "Организация",
                value: profile.organization,
                icon: FontAwesomeIcons.solidBuilding,
                unit: "",
                iconColor: ModernTextTheme.captionIconColor,
              ),
              SizedBox(height: 24.0),
              TwoLineInformationWidgetExpanded(
                title: "Номер телефона",
                value: profile.phoneNumber,
                icon: FontAwesomeIcons.phone,
                unit: "",
                iconColor: ModernTextTheme.captionIconColor,
                onTap: () => launch('tel:${profile.phoneNumber}'),
              ),
            ],
          ),
        ),
        if (profile.isCurrentUser) ...[
          SizedBox(height: 24.0),
          buildCard(
            child: SingleLineInformationWidget(
              icon: Icons.exit_to_app,
              label: 'Выйти из профиля',
              color: Colors.indigo,
            ),
            onTap: () => Api.logOut(context),
          ),
        ],
        SizedBox(height: 24.0),
        buildCard(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.zero, left: Radius.circular(12.0)),
                  onTap: () => controller.setIsCargoSelected(true),
                  child: Container(
                    height: 64.0,
                    child: Center(
                      child: Text(
                        "Грузы",
                        style: ModernTextTheme.primaryAccented.copyWith(
                          color: (controller.isCargoSelected)
                              ? Colors.indigo
                              : Colors.black,
                          fontWeight: (controller.isCargoSelected)
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(12.0), left: Radius.zero),
                  onTap: () => controller.setIsCargoSelected(false),
                  child: Container(
                    height: 64.0,
                    child: Center(
                      child: Text(
                        "Транспорт",
                        style: ModernTextTheme.primaryAccented.copyWith(
                          color: (!controller.isCargoSelected)
                              ? Colors.indigo
                              : Colors.black,
                          fontWeight: (!controller.isCargoSelected)
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        if (controller.isCargoSelected)
          ...buildProfileDataSection(
            data: controller.cargo,
            builder: (item) => CargoWidget(heroPrefix: "profile", data: item),
            isLoading: controller.isCargoLoading,
            onRefresh: () => controller.loadCargo(context: context),
          )
        else
          ...buildProfileDataSection(
            data: controller.vehicle,
            builder: (item) => VehicleWidget(heroPrefix: "profile", data: item),
            isLoading: controller.isVehicleLoading,
            onRefresh: () => controller.loadVehicle(context: context),
          ),
      ],
    );
  }

  @override
  Widget present(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          AppBarWidget(
            title: Text('Профиль ' + (controller?.data?.username ?? '')),
            includeBackButton: widget.includeBackButton,
            accentColor: Colors.indigo,
            action: (controller?.data?.isCurrentUser ?? false)
                ? IconButton(
                    color: Colors.indigo,
                    icon: Icon(Icons.edit),
                    onPressed: (controller.data != null)
                        ? () => editProfile(context)
                        : null,
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
                        buildProfile(profile: profile),
                  ),
                  onRefresh: () async => await controller.load(
                      context: context, uid: widget.uid),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
