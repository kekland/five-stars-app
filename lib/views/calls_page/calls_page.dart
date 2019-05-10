import 'package:five_stars/design/app_bar_widget.dart';
import 'package:five_stars/design/card_widget.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class CallsPage extends StatelessWidget {
  const CallsPage({Key key}) : super(key: key);

  void call() {
    UrlLauncher.launch("tel:+77775445000");
  }

  void requestCallAPI(BuildContext context) async {
    //TODO
    Navigator.of(context).pop();

    showLoadingDialog(context: context, color: Colors.deepPurple);
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pop();

    showModernDialog(
      context: context,
      title: 'Запрос отправлен.',
      text: 'Наш оператор перезвонит вам в ближайшее время',
      actions: <Widget>[
        FlatButton(
          child: Text('Хорошо'),
          onPressed: () => Navigator.of(context).pop(),
          textColor: Colors.deepPurple,
        ),
      ],
    );
  }

  void requestCall(BuildContext context) {
    showModernDialog(
      context: context,
      title: 'Запросить звонок?',
      text: 'Наш оператор перезвонит вам в ближайшее время',
      actions: <Widget>[
        FlatButton(
          child: Text('Отмена'),
          onPressed: () => Navigator.of(context).pop(),
          textColor: Colors.deepPurple,
        ),
        FlatButton(
          child: Text('Запросить'),
          onPressed: () => requestCallAPI(context),
          textColor: Colors.deepPurple,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          AppBarWidget(
            title: Text('Связаться с нами'),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CardWidget(
                    padding: const EdgeInsets.all(16.0),
                    body: TwoLineInformationWidget(
                      icon: FontAwesomeIcons.phone,
                      iconColor: ModernTextTheme.captionIconColor,
                      title: 'Наш номер',
                      unit: '',
                      value: '+7 (777) 554 50 00',
                    ),
                    actions: [
                      Expanded(
                        child: FlatButton(
                          child: Text('Позвонить'),
                          padding: const EdgeInsets.all(18.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          onPressed: call,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text('или', style: ModernTextTheme.boldTitle.copyWith(color: ModernTextTheme.captionColor)),
                  SizedBox(height: 16.0),
                  CardWidget(
                    padding: const EdgeInsets.all(16.0),
                    body: Center(
                      child: Text(
                        'Запрос звонка от оператора',
                        style: ModernTextTheme.secondary,
                      ),
                    ),
                    actions: [
                      Expanded(
                        child: FlatButton(
                          child: Text('Запросить'),
                          padding: const EdgeInsets.all(18.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          onPressed: () => requestCall(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
