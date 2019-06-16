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
                  'Нет данных. Потяните сверху, чтобы обновить.',
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
        /*if(index == 0) return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: CargoFilterWidget(),
        );*/
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: builder(context, data[index]),
        );
      },
    );
  }
}

ListView buildSingularDataPage<T>({
  final BuildContext context,
  final T data,
  final bool isLoading,
  final ListView Function(BuildContext context, T data) builder,
  final Color accentColor,
}) {
  if (data == null && !isLoading) {
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
  } else {
    return builder(context, data);
  }
}