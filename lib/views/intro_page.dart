import 'package:five_stars/views/logo_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  bool loaded = false;
  AnimationController inflationAnimationController;
  Animation<double> inflationAnimation;
  Animation<double> inflationAnimationEased;

  AnimationController buttonRaiseAnimationController;
  Animation<double> buttonRaiseAnimation;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        loaded = true;
        inflationAnimationController.forward();
        buttonRaiseAnimationController.forward();
      });
    });
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

    buttonRaiseAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    buttonRaiseAnimationController.addListener(() => setState(() {}));

    buttonRaiseAnimation = CurvedAnimation(
      parent: buttonRaiseAnimationController,
      curve: Curves.elasticOut,
    );
  }

  Widget buildLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: Offset(-30.0 * (1.0 - inflationAnimation.value), 0.0),
          child: Opacity(
            opacity: inflationAnimationEased.value,
            child: TextLogoWidget(),
          ),
        ),
        SizedBox(height: 16.0),
        Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: inflationAnimationEased.value,
              child: Transform.translate(
                offset: Offset(-30.0 * (1.0 - inflationAnimation.value), 0.0),
                child: IconLogoWidget(
                  size: MediaQuery.of(context).size.shortestSide / 2.0,
                ),
              ),
            ),
            Opacity(
              opacity: (1.0 - inflationAnimationEased.value * 2.0).clamp(0.0, 1.0),
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
              FlatButton(
                  child: Text('restart'),
                  onPressed: () {
                    loaded = false;
                    inflationAnimationController.reset();
                    buttonRaiseAnimationController.reset();
                    Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
                      setState(() {
                        loaded = true;
                        inflationAnimationController.forward(from: 0.0);
                        buttonRaiseAnimationController.forward(from: 0.0);
                      });
                    });
                  }),
              Align(
                alignment: Alignment(0.0, -0.35),
                child: buildLogo(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton.icon(
                    onPressed: () => {},
                    shape: StadiumBorder(),
                    icon: Icon(Icons.chevron_right),
                    label: Text('Вход в систему'),
                    color: Colors.blue,
                    textColor: Colors.white,
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
