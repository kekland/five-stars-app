import 'package:five_stars/design/text_field.dart';
import 'package:five_stars/design/typography/typography.dart';
import 'package:five_stars/utils/utils.dart';
import 'package:five_stars/views/two_line_information_widget.dart';
import 'package:flutter/material.dart';

class StringSelectWidget extends StatelessWidget {
  final String value;
  final Function(String) onSelected;
  final IconData icon;
  final String title;

  const StringSelectWidget(
      {Key key, this.value, this.onSelected, this.icon, this.title})
      : super(key: key);

  void onTap(BuildContext context) async {
    TextEditingController controller = TextEditingController(
      text: (value != null) ? value.toString() : '',
    );

    String returnValue = await showModernDialog<String>(
      context: context,
      title: 'Выберите значение',
      body: StatefulBuilder(builder: (context, setState) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              ModernTextField(
                hintText: 'Значение',
                icon: icon,
                controller: controller,
                error: (controller.text.isEmpty)
                    ? 'Неправильное значение'
                    : null,
                onChanged: (_) => setState(() => {}),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                      child: Text('Отмена'),
                      onPressed: () => Navigator.of(context).pop()),
                  FlatButton(
                    child: Text('Выбрать'),
                    textColor: Colors.indigo,
                    onPressed: (controller.text.isNotEmpty)
                        ? () => Navigator.of(context).pop(controller.text)
                        : null,
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
    if (returnValue != null) {
      onSelected(returnValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => onTap(context),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TwoLineInformationWidgetExpanded(
            icon: icon,
            iconColor: ModernTextTheme.captionIconColor,
            value: value != null ? '${value.toString()}' : 'Пусто',
            unit: '',
            title: title,
          ),
        ),
      ),
    );
  }
}
