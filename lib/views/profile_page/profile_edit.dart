import 'package:five_stars/controllers/profile_edit_controller.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/models/user_model.dart';
import 'package:five_stars/mvc/view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileEditPage extends StatefulWidget {
  final User data;

  const ProfileEditPage({Key key, this.data}) : super(key: key);
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState
    extends Presenter<ProfileEditPage, ProfileEditController> {
  @override
  void initController() {
    controller = ProfileEditController(presenter: this);
    controller.setFields(widget.data);
  }

  Widget buildFields(BuildContext context) {
    return CardWidget(
      padding: const EdgeInsets.all(16.0),
      body: Column(
        children: <Widget>[
          ModernTextField(
            icon: FontAwesomeIcons.solidEnvelope,
            hintText: "Почта",
            controller: controller.emailController,
            error: controller.email.error,
            onSubmitted: controller.email.validate,
            onChanged: controller.email.setValue,
          ),
          SizedBox(height: 16.0),
          ModernTextField(
            icon: FontAwesomeIcons.solidUser,
            hintText: "Имя",
            controller: controller.nameController,
            error: controller.name.error,
            onSubmitted: controller.name.validate,
            onChanged: controller.name.setValue,
          ),
          SizedBox(height: 16.0),
          ModernTextField(
            icon: FontAwesomeIcons.solidBuilding,
            hintText: "Организация",
            controller: controller.organizationController,
            error: controller.organization.error,
            onSubmitted: controller.organization.validate,
            onChanged: controller.organization.setValue,
          ),
          SizedBox(height: 16.0),
          ModernTextField(
            hintText: "Номер телефона",
            prefix: Text(
              "+7",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontFamily: "Inter",
                  textBaseline: TextBaseline.alphabetic),
            ),
            keyboardType: TextInputType.phone,
            icon: Icons.phone,
            controller: controller.phoneNumberController,
            error: controller.phoneNumber.error,
            onSubmitted: controller.phoneNumber.validate,
            onChanged: controller.phoneNumber.setValue,
          ),
        ],
      ),
    );
  }

  Widget buildAlterWidget(BuildContext context) {
    return CardWidget(
      padding: EdgeInsets.zero,
      body: SizedBox(
        width: double.infinity,
        height: 56.0,
        child: FlatButton(
          child: Text('Изменить'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          onPressed:
              (controller.isValid())? () => controller.editProfile(context) : null,
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
                body:
                    Text('Изменить профиль', style: ModernTextTheme.boldTitle),
              ),
              SizedBox(height: 16.0),
              buildFields(context),
              SizedBox(height: 16.0),
              buildAlterWidget(context),
            ],
          ),
        ),
      ),
    );
  }
}
