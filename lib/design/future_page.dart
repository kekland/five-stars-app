import 'package:five_stars/design/circular_progress_reveal_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum FutureState { NotRan, Loading, Error, Success }

ListView buildDataPage<T>({
  final List<T> data,
  final String error,
  final Widget Function(BuildContext context, T item) builder,
  final Color accentColor,
}) {
  if (error != null) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(FontAwesomeIcons.solidFrownOpen,
                    color: ModernTextTheme.captionIconColor),
                SizedBox(height: 8.0),
                Text(
                  'Что-то пошло не так. Потяните сверху, чтобы обновить.',
                  style: ModernTextTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  } else if (data == null) {
    return ListView();
  } else if (data.isEmpty) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(FontAwesomeIcons.boxOpen,
                    color: ModernTextTheme.captionIconColor),
                SizedBox(height: 8.0),
                Text(
                  'Нет грузов. Потяните сверху, чтобы обновить.',
                  style: ModernTextTheme.caption,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
      ],
    );
  } else {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      physics: BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: builder(context, data[index]),
        );
      },
    );
  }
}

class FuturePage extends StatefulWidget {
  final FutureState state;
  final String error;
  final Widget Function() onSuccess;
  final VoidCallback onRefresh;
  final Color accentColor;

  const FuturePage(
      {Key key,
      this.state,
      this.error,
      this.onSuccess,
      this.onRefresh,
      this.accentColor})
      : super(key: key);

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
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

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
      return Center(
          child: CircularProgressRevealWidget(color: widget.accentColor));
    }
    if (widget.state == FutureState.Error) {
    } else {
      return Stack(
        children: [
          Opacity(
            opacity: progressOpacityAnimation.value,
            child: Center(
              child: CircularProgressRevealWidget(color: widget.accentColor),
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
