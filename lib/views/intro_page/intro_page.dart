import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/intro_page/logo_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  bool loaded = false;
  AnimationController inflationAnimationController;
  Animation<double> inflationAnimation;
  Animation<double> inflationAnimationEased;

  AnimationController deflationAnimationController;
  Animation<double> deflationAnimation; 

  @override
  void dispose() {
    inflationAnimationController.dispose();
    deflationAnimationController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

    inflationAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1350),
    );
    inflationAnimationController.addListener(() => setState(() {}));

    inflationAnimation = CurvedAnimation(
      parent: inflationAnimationController,
      curve: Curves.elasticOut,
    );
    inflationAnimationEased = CurvedAnimation(
      parent: inflationAnimationController,
      curve: Curves.fastLinearToSlowEaseIn,
    );

    deflationAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    deflationAnimationController.addListener(() => setState(() {}));

    deflationAnimation = CurvedAnimation(
      parent: deflationAnimationController,
      curve: Curves.easeInOut,
    );

    runAnimation();
  }

  void runAnimation() {
    setState(() {
      inflationAnimationController.reset();
      deflationAnimationController.reset();
      loaded = false;
    });

    Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        loaded = true;
        inflationAnimationController.forward();
      });
    });

    Future.delayed(Duration(seconds: 1), () {
      deflationAnimationController.forward();
    });
  }

  Widget buildLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextLogoWidget(),
        SizedBox(height: 24.0),
        Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: inflationAnimationEased.value,
              child: Transform.translate(
                offset: Offset(-30.0 * (1.0 - inflationAnimationEased.value), 0.0),
                child: IconLogoWidget(
                  size: MediaQuery.of(context).size.shortestSide / 2.0,
                ),
              ),
            ),
            Opacity(
              opacity: (1.0 - deflationAnimation.value),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Stack(
            children: [
              /*FlatButton(
                  child: Text('restart'),
                  onPressed: runAnimation,
              ),*/
              Align(
                alignment: Alignment(0.0, -0.35),
                child: buildLogo(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Opacity(
                  opacity: inflationAnimationEased.value,
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          (SharedPreferencesManager.instance.getString("token") != null ? "/main" : "/auth"),
                        );
                      },
                      shape: StadiumBorder(),
                      icon: Icon(Icons.chevron_right),
                      label: Text('Вход в систему'),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
