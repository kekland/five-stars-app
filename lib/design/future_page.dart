import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:flutter/material.dart';

enum FutureState { NotRan, Loading, Error, Success }

class FuturePage extends StatefulWidget {
  final FutureState state;
  final String error;
  final Widget Function() onSuccess;
  final VoidCallback onRefresh;

  const FuturePage({Key key, this.state, this.error, this.onSuccess, this.onRefresh}) : super(key: key);

  @override
  _FuturePageState createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> with TickerProviderStateMixin {
  FutureState state;
  FutureState newState;

  AnimationController animationController;
  Animation<double> progressOpacityAnimation;
  Animation<double> contentOpacityAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

    progressOpacityAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    contentOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.6, 1.0, curve: Curves.fastLinearToSlowEaseIn),
      ),
    );

    animationController.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(FuturePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      state = oldWidget.state;
      newState = widget.state;

      if (state == FutureState.Loading && newState == FutureState.Success) {
        animationController.forward(from: 0.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state == FutureState.Loading) {
      return Center(child: CircularProgressRevealWidget());
    }
    if (widget.state == FutureState.Error) {
      return Center(child: Text('Что-то пошло не так.'));
    } else {
      return Stack(
        children: [
          Opacity(
            opacity: progressOpacityAnimation.value,
            child: Center(
              child: CircularProgressRevealWidget(),
            ),
          ),
          Transform.translate(
            offset: Offset(-100.0 * (1.0 - contentOpacityAnimation.value), 0.0),
            child: Opacity(
              opacity: contentOpacityAnimation.value,
              child: widget.onSuccess(),
            ),
          ),
        ],
      );
    }
  }
}
