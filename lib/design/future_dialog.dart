import 'package:five_stars/design/future_page.dart';
import 'package:five_stars/design/shadows/shadows.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:flutter/material.dart';

class DialogData {
  final String title;
  final String subtitle;
  final Widget customBody;
  final List<Widget> actions;

  DialogData(
      {this.title, this.subtitle, this.customBody, this.actions = const []});
}

class FutureDialog extends StatelessWidget {
  final DialogData data;

  const FutureDialog({
    Key key,
    @required this.data,
  }) : super(key: key);

  Widget buildBeforeFuture(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(data.title, style: ModernTextTheme.title),
          SizedBox(height: 16.0),
          if (data.subtitle != null) ...[
            Text(data.subtitle, style: ModernTextTheme.caption),
            SizedBox(height: 16.0),
          ],
          if (data.customBody != null) ...[
            Expanded(child: data.customBody),
          ],
          if (data.actions != null) ...[
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: data.actions,
              ),
            ),
          ],
        ],
      ),
      padding: const EdgeInsets.only(
          top: 24.0, left: 32.0, right: 32.0, bottom: 16.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Material(
          color: Colors.transparent,
          child: buildBeforeFuture(context),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [Shadows.slightShadow],
        ),
      ),
    );
  }
}
